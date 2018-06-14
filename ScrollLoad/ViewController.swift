//
//  ViewController.swift
//  ScrollLoad
//
//  Created by 许允是 on 2018/6/8.
//  Copyright © 2018年 XYS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.sl.header = ScrollLoadNormalHeader(target: self, action: #selector(loadData))
    }
    
    @objc func loadData() {
        DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
            print("loadData")
            self.scrollView.sl.header?.endRefresh()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func push(_ sender: Any) {
        navigationController?.pushViewController(UIViewController(), animated: true)
    }
    
}

