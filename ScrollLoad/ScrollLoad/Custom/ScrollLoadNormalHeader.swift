//
//  ScrollLoadNormalHeader.swift
//  ScrollLoad
//
//  Created by 许允是 on 2018/6/13.
//  Copyright © 2018年 XYS. All rights reserved.
//

import UIKit

class ScrollLoadNormalHeader: ScrollLoadBaseHeader {
    
    override func fireHeight() -> CGFloat {
        
        return ScrollLoadNormalHeaderHeight
    }
    
    override func customView() -> ScrollLoadSubViewProtocol? {
        
        return normalHeader
    }
    
    fileprivate lazy var normalHeader: ScrollLoadSubViewProtocol = {
        
        return ScrollLoadNormalHeaderContentView()
    }()
}

class ScrollLoadNormalHeaderContentView: ScrollLoadBaseContentView {
    
    override init(frame: CGRect) {

        super.init(frame: frame)
        addSubview(stateLabel)
//        addSubview(updateTimeLabel)
//        syncTimeLabel()
    }
    required init?(coder aDecoder: NSCoder) {
        
        fatalError()
    }
    
    override func layoutSubviews() {
        
        stateLabel.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height / 2)
//        updateTimeLabel.frame = CGRect(x: 0, y: bounds.height / 2, width: bounds.width, height: bounds.height / 2)
        super.layoutSubviews()
    }
    
//    fileprivate lazy var updateTimeLabel: UILabel = {
//
//        return UILabel.sl_label()
//    }()
    
    fileprivate lazy var stateLabel: UILabel = {
        
        return UILabel.sl_label()
    }()
    
//    func lastRefreshTime() -> String? {
//
//        let userDefaultDic = UserDefaults.standard.dictionaryRepresentation()
//
//        if let date = userDefaultDic[kScrollLoadUserDefaultDateKey] as? Date {
//
//            let formatter = DateFormatter()
//            formatter.setLocalizedDateFormatFromTemplate("hh点MM分")
//            return formatter.string(from: date)
//        }
//        return "无记录"
//    }
//
//    func storeRefreshTime() {
//        UserDefaults.standard.set(Date(), forKey: kScrollLoadUserDefaultDateKey)
//    }
//
//    func syncTimeLabel() {
//
//        updateTimeLabel.text = lastRefreshTime()
//    }
//
    override func respond(to state: ScrollLoadState) {
        
        switch state {
        case .refreshing:
            stateLabel.text = "正在刷新数据中..."
        case .willRefresh:
            stateLabel.text = "松手就可以刷新啦"
        case .idle:
            stateLabel.text = "下拉可以刷新"
        case .pulling:
            stateLabel.text = "松开立即刷新"
        default:
            stateLabel.text = "下拉可以刷新"
        }
    }
}

extension UILabel {
    
    static func sl_label() -> UILabel {
        
        let label = UILabel()
        label.font = ScrollLoadDefaltFont
        label.textColor = ScrollLoadDefaultColor
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }
}
