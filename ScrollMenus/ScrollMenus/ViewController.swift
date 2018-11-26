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
        
        let menu1 = MenuModel(title: "购买记录",
                              imageNormal: nil,
                              imageSelected: nil)
        let menu2 = MenuModel(title: "680人",
                              imageNormal: #imageLiteral(resourceName: "personNumber_normal"),
                              imageSelected: #imageLiteral(resourceName: "personNumber_selected"))
        let menu3 = MenuModel(title: "商品详情",
                              imageNormal: nil,
                              imageSelected: nil)
        
        let menu = ScrollMenus(titles: [menu1, menu2, menu3],
                               frame: menuView.bounds,
                               menuHeight: 44)
        menuView.addSubview(menu)
    }
}

