//
//  ScrollLoad.swift
//  ScrollLoad
//
//  Created by 许允是 on 2018/6/9.
//  Copyright © 2018年 XYS. All rights reserved.
//

import UIKit

public final class ScrollLoad<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

/// A type that has ScrollLoad type
public protocol ScrollLoadCompatible {
    associatedtype Compatibletype
    var sl: Compatibletype { get }
}

public extension ScrollLoadCompatible {
    public var sl: ScrollLoad<Self> {
        return ScrollLoad(self)
    }
}

extension UIScrollView: ScrollLoadCompatible {}
