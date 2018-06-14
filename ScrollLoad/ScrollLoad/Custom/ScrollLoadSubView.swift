//
//  ScrollLoadSubView.swift
//  ScrollLoad
//
//  Created by 许允是 on 2018/6/12.
//  Copyright © 2018年 XYS. All rights reserved.
//

import UIKit

protocol ScrollLoadSubViewProtocol {
    
    func respond(to state: ScrollLoadState)
}

class ScrollLoadBaseContentView: UIView, ScrollLoadSubViewProtocol{
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        respond(to: .idle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError()
    }
    
    func respond(to state: ScrollLoadState) {}
}
