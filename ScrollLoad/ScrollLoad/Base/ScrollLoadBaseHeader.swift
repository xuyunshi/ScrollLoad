//
//  ScrollLoadBaseHeader.swift
//  ScrollLoad
//
//  Created by 许允是 on 2018/6/13.
//  Copyright © 2018年 XYS. All rights reserved.
//

import UIKit

class ScrollLoadBaseHeader: ScrollLoadBaseComponent {
    
    override func placeSelf() {
        
        guard let superView = scrollView else { return }
        frame = CGRect(x: 0, y: -fireHeight(), width: superView.bounds.width, height: fireHeight())
    }
    
    override func respond(to state: ScrollLoadState) {

        switch state {
        case .refreshing:
            UIView.animate(withDuration: ScrollLoadNormalAnimationTimeDuration) {
                self.scrollView?.contentInset.top = self.fireHeight()
            }
        default:
            if let originalInsets = originalInsets {
                UIView.animate(withDuration: ScrollLoadNormalAnimationTimeDuration) {
                    self.scrollView?.contentInset = originalInsets
                }
            }
            return
        }
    }
    
    override func scrollViewContentOffsetDidChange(change: [NSKeyValueChangeKey : Any]?){
        
        guard let change = change, let new = change[NSKeyValueChangeKey.newKey] as? CGPoint else { return }
        print("current state is \(state), offset is \(-new.y)")
        switch  state{
        case .refreshing:
            return
        case .idle:
            if -new.y > 10.0 {
                state = .pulling
            }
        default:
            if -new.y > fireHeight() {
                state = .willRefresh
            }
            return
        }
    }
    
    override func scrollViewPanStateDidChange(change: [NSKeyValueChangeKey : Any]?){
        
        guard let change = change else { return }
        if let newValue = change[NSKeyValueChangeKey.newKey] as? Int, let newState = UIGestureRecognizerState(rawValue: newValue) {
            if newState == .ended, state == .willRefresh{
                beginRefresh()
            }
        }
    }
}
