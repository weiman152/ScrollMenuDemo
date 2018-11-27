# ScrollMenuSwift

Swift4, 滑动菜单View，支持滑动，点击切换，不依赖任何三方，纯手工计算，目前不完善，
只有底部滑动条的样式，代理也不够完善，开发中。。。

环境：

xcode10.1 ， swift4

截图：
<br>
![Alt text](https://github.com/weiman152/ScrollMenuSwift/blob/master/screenShot/111.gif)


使用：
<br>
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
private var menus: [MenuModel] = []

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
menus = [menu1, menu2, menu3]
let menu = ScrollMenus(titles: menus,
frame: menuView.bounds,
menuHeight: 44)
menu.dataSource = self
menu.delegate = self
menu.set(menuIndex: 1)
menu.lineColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
menu.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
menu.textSeletedColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
menuView.addSubview(menu)
}
}

extension ViewController: ScrollMenusDataSource {

func menuViewNumberOfItems() -> Int {
return menus.count
}

func menuViewViewForItems(atIndex: Int) -> UIView {
guard atIndex < menus.count else {
return UIView()
}
switch atIndex {
case 0:
let vc = FirstViewController.instance()
return vc.view
case 1:
let vc = SecondViewController.instance()
return vc.view
case 2:
let vc = FirstViewController.instance()
return vc.view
default:
return UIView()
}
}
}

extension ViewController: ScrollMenusDelegate {

func menuDidChange(currentIndex: Int) {
print("------------  \(currentIndex)")
}
}



备注：正在完善中
