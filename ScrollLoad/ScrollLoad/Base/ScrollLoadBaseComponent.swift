//
//  ScrollLoadComponentView.swift
//  ScrollLoad
//
//  Created by 许允是 on 2018/6/13.
//  Copyright © 2018年 XYS. All rights reserved.
//

import UIKit

class ScrollLoadBaseComponent: UIView {
    
    // 原始Insets
    var originalInsets: UIEdgeInsets?
    
    var scrollView: UIScrollView?
    
    // scrollView的panGesture
    var pan: UIPanGestureRecognizer?
    
    var target: NSObject?
    
    var action: Selector?
    
    var state: ScrollLoadState = .idle {
        
        willSet {
            
            // 旧值和新值一样就不处理任何事情
            if newValue == state { return }
            // 更新子视图的响应
            customView()?.respond(to: newValue)
            // 更新自身对state的响应
            respond(to: newValue)
        }
    }
    
    init(target: NSObject, action: Selector) {
        
        super.init(frame: .zero)
        self.target = target
        self.action = action
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {

        super.willMove(toSuperview: newSuperview)

        // 保证父视图是ScrollView
        guard let superView = newSuperview as? UIScrollView else { return }

        superView.alwaysBounceVertical = true
        originalInsets = superView.contentInset
        scrollView = superView

        // 布局
        placeSelf()
        placeSubViews()

        // 移除旧的监听
        self.removeObservers()

        // 添加新的监听
        self.addObservers()
    }
    // MARK: Layout
    override func layoutSubviews() {
        if let customView = customView() as? UIView {
            customView.frame = bounds
        }
        superview?.layoutSubviews()
    }
    func placeSelf() {}
    final func placeSubViews() {
        if let view = customView() as? UIView {
            addSubview(view)
        }
    }
    func respond(to state: ScrollLoadState) {}
    // MARK: - DataSource
    // 触发高度
    func fireHeight() ->CGFloat {
        return ScrollLoadComponentHeight
    }
    // 子视图
    func customView() -> ScrollLoadSubViewProtocol? {
        return nil
    }
    // MARK: - Action
    func beginRefresh() {
        state = .refreshing
        if let target = target, let action = action {
            target.performSelector(onMainThread: action, with: nil, waitUntilDone: false)
        }
    }
    func endRefresh() {
        state = .idle
    }
    
    // MARK: - KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

        if let change = change, let path = keyPath {
            switch path {
            case ScrollLoadKeyContentOffset:
                scrollViewContentOffsetDidChange(change: change)
            case ScrollLoadKeyPanState:
                scrollViewPanStateDidChange(change: change)
            default:
                return
            }
        }
    }
    
    func removeObservers() {
        
        if let supertView = superview, let pan = pan {
            supertView.removeObserver(self, forKeyPath: ScrollLoadKeyContentOffset)
            supertView.removeObserver(self, forKeyPath: ScrollLoadKeyContentSize)
            pan.removeObserver(self, forKeyPath: ScrollLoadKeyPanState)
            self.pan = nil
        }
    }
    
    func addObservers() {
        
        if let scrollView = scrollView {
            let options:NSKeyValueObservingOptions = [NSKeyValueObservingOptions.new, NSKeyValueObservingOptions.old]
            scrollView.addObserver(self, forKeyPath: ScrollLoadKeyContentSize, options: options, context: nil)
            scrollView.addObserver(self, forKeyPath: ScrollLoadKeyContentOffset, options: options, context: nil)
            scrollView.panGestureRecognizer.addObserver(self, forKeyPath: ScrollLoadKeyPanState, options: options, context: nil)
            pan = scrollView.panGestureRecognizer
        }
    }
    
    func scrollViewContentOffsetDidChange(change: [NSKeyValueChangeKey : Any]?) {}
    func scrollViewContentSizeDidChange(change: [NSKeyValueChangeKey : Any]?) {}
    func scrollViewPanStateDidChange(change: [NSKeyValueChangeKey : Any]?) {}
}
