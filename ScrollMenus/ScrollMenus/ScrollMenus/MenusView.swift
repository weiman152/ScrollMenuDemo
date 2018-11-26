//
//  MenusView.swift
//  ScrollMenus
//
//  Created by iOS on 2018/11/20.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

protocol MenusViewDelegate: NSObjectProtocol {
    
    /// 菜单被点击
    func menuClick(index: Int)
}

class MenusView: UIView {
    
    weak var delegate: MenusViewDelegate?
    
    private var titles: [MenuModel] = []
    private var titleButtons: [UIButton] = []
    private var currentSelectIndex: Int = 0
    
    init(titles: [MenuModel], frame: CGRect) {
        self.titles = titles
        super.init(frame: frame)
        setup()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        setupLayout()
    }
    
    private func setup() {
        
        guard titles.count > 0 else {
            return
        }
        // 根据给出的标题创建按钮，平分屏幕
        for (i, menu) in titles.enumerated() {
            let button = makeButton(index: i, menu: menu)
            addSubview(button)
            titleButtons.append(button)
        }
        
    }
    
    private func setupLayout() {
        
    }

}

extension MenusView {
    
    public func set(title: String, index: Int) {
        
    }
    
    public func reload(titles: [String]) {
        
    }
    
    public func setSelect(index: Int) {
        guard index < titleButtons.count else {
            return
        }
        currentSelectIndex = index
        for button in titleButtons {
            button.isSelected = (button.tag == index) ? true : false
        }
    }
    
    public func currentIndex() -> Int {
        return currentSelectIndex
    }
    
    /// 正在选中的菜单的frame
    public func selectedFrame() -> CGRect {
        let button = titleButtons[currentSelectIndex]
        return button.frame
    }
    
    /// 正在选中的菜单下一个(右边的)frame
    public func nextMenuFrame() -> CGRect? {
        guard currentSelectIndex < titleButtons.count,
              isLastMenu() == false else {
            return nil
        }
        let button = titleButtons[currentSelectIndex + 1]
        return button.frame
    }
    
    /// 正在选中的菜单上一个(左边的)frame
    public func previousMenuFrame() -> CGRect? {
        guard currentSelectIndex > 0 else {
            return nil
        }
        let button = titleButtons[currentSelectIndex - 1]
        return button.frame
    }
    
    /// 是否是最后一个菜单
    public func isLastMenu() -> Bool {
        return currentSelectIndex == (titleButtons.count - 1)
    }
    
    /// 获取小横线滑动的距离
    public func getScrollDistance() -> CGFloat {
        guard titleButtons.count > 1 else {
            return 0
        }
        let centerX1 = titleButtons[0].center.x
        let centerX2 = titleButtons[1].center.x
        let dis = centerX2 - centerX1
        return dis
    }
}

// MARK: - private funcs
extension MenusView {
    
    private func makeButton(index: Int, menu: MenuModel) -> UIButton {
        
        let width = bounds.size.width / CGFloat(titles.count)
        let height = bounds.size.height
        
        let button = UIButton(type: .custom)
        button.tag = index
        let x = CGFloat(index) * width
        button.frame = CGRect(x: x, y: 0, width: width, height: height)
        button.setTitle(menu.title, for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.3725490196, green: 0.3725490196, blue: 0.3725490196, alpha: 1), for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 0.5019607843, blue: 0, alpha: 1), for: .selected)
        button.setImage(menu.imageNormal, for: .normal)
        button.setImage(menu.imageSelected, for: .selected)
        button.isSelected = (button.tag == currentSelectIndex) ? true : false
        button.addTarget(self, action: #selector(buttonAction(button:)), for: .touchUpInside)
        return button
    }
    
    @objc private func buttonAction(button: UIButton) {
        if currentSelectIndex != button.tag {
            setSelect(index: button.tag)
            delegate?.menuClick(index: button.tag)
        }
        
    }
    
}
