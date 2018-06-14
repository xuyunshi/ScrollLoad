//
//  UIScrollView+ScrollLoad.swift
//  ScrollLoad
//
//  Created by 许允是 on 2018/6/9.
//  Copyright © 2018年 XYS. All rights reserved.
//

import UIKit

extension ScrollLoad where Base:UIScrollView {
    var header: ScrollLoadBaseComponent? {
        get {
            return objc_getAssociatedObject(base, &ScrollLoadHeaderAssociateKey) as? ScrollLoadBaseComponent
        }
        set {
            // 有旧值要先去除
            if let header = header {
                header.removeFromSuperview()
            }
            // 然后关联类型
            objc_setAssociatedObject(base, &ScrollLoadHeaderAssociateKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            // 然后根据是否为空添加到视图层级
            if let newHeader = newValue {
                base.addSubview(newHeader)
            }
        }
    }
    var footer: ScrollLoadBaseComponent? {
        get {
            return objc_getAssociatedObject(base, &ScrollLoadFooterAssociateKey) as? ScrollLoadBaseComponent
        }
        set {
            if let footer = footer {
                footer.removeFromSuperview()
            }
            objc_setAssociatedObject(base, &ScrollLoadFooterAssociateKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if let newFooter = newValue {
                base.addSubview(newFooter)
            }
        }
    }
}
