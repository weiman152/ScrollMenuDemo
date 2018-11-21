//
//  ViewController.swift
//  ScrollMenus
//
//  Created by iOS on 2018/11/20.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var menuView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    private func setup() {
        let menu = ScrollMenus(titles: ["购买记录", "680人", "商品详情"],
                               menuHeight: 44,
                               frame: menuView.bounds)
        menuView.addSubview(menu)
    }
}

