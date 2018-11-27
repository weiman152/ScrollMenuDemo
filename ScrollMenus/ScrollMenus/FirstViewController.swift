//
//  FirstViewController.swift
//  ScrollMenus
//
//  Created by iOS on 2018/11/27.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    static func instance() -> FirstViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
        return vc
    }

}
