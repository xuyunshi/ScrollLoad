//
//  ScrollLoadConst.swift
//  ScrollLoad
//
//  Created by 许允是 on 2018/6/13.
//  Copyright © 2018年 XYS. All rights reserved.
//

import UIKit

enum ScrollLoadState {
    case idle
    case pulling
    case refreshing
    case willRefresh
    case noMoreData
    case unknow
}

let ScrollLoadDefaultColor = UIColor(red: 90/255.0, green: 90/255.0, blue: 90/255.0, alpha: 1.0)

let ScrollLoadDefaltFont = UIFont.boldSystemFont(ofSize: 14)

let kScrollLoadUserDefaultDateKey = "ScrollLoadUserDefaultDateKey"

let ScrollLoadKeyContentOffset = "contentOffset"
let ScrollLoadKeyContentSize = "contentSize"
let ScrollLoadKeyPanState = "state"

let ScrollLoadNormalAnimationTimeDuration = 0.5

let ScrollLoadNormalHeaderHeight = CGFloat(54.0)
let ScrollLoadComponentHeight = CGFloat(20.0)

var ScrollLoadHeaderAssociateKey: Void?
var ScrollLoadFooterAssociateKey: Void?
