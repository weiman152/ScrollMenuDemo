//
//  ScrollMenus.swift
//  ScrollMenus
//
//  Created by iOS on 2018/11/20.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

class ScrollMenus: UIView {
    
    private var menus: MenusView!
    private var line: UIView!
    private var collectionView: UICollectionView!
    private var titles: [String] = []
    private var menuHeight: CGFloat = 44
    private let collectionViewModel = CollectionViewModel()
    private var lineOriginalX: CGFloat?
    
    init(titles: [String], menuHeight: CGFloat = 44, frame: CGRect) {
        self.titles = titles
        self.menuHeight = menuHeight
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        setMenus()
        setLine()
        setCollectionView()
    }
    
}

extension ScrollMenus {
    
    private func setMenus() {
        let frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: menuHeight)
        menus = MenusView(titles: titles, frame: frame)
        menus.delegate = self
        addSubview(menus)
    }
    
    private func setLine() {
        line = UIView(frame: getLineFrame())
        line.backgroundColor = #colorLiteral(red: 1, green: 0.5019607843, blue: 0, alpha: 1)
        addSubview(line)
    }
    
    private func setCollectionView() {
        let frame = CGRect(x: 0,
                           y: menuHeight,
                           width: bounds.size.width,
                           height: bounds.size.height - menuHeight)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: frame,
                                          collectionViewLayout: layout)
        addSubview(collectionView)
        collectionViewModel.delegate = self
        collectionViewModel.set(collectionView: collectionView,
                                itemCount: titles.count)
    }
    
    private func getLineFrame() -> CGRect {
        let selectFrame = menus.selectedFrame()
        var temp: CGFloat = 22
        if selectFrame.size.width > temp {
            temp = 22
        } else {
            temp = selectFrame.size.width
        }
        let x =  selectFrame.origin.x + (selectFrame.size.width - temp) / 2.0
        let frame = CGRect(x: x,
                           y: selectFrame.size.height - 4,
                           width: temp,
                           height: 4)
        return frame
    }
    
    private func updateLineFrame() {
        line.frame = getLineFrame()
        layoutIfNeeded()
    }
}

extension ScrollMenus: CollectionViewModelDelegate {
    
    func menuDidChange(index: Int) {
        menus.setSelect(index: index)
        updateLineFrame()
    }
    
    func menuDidScroll(offset: CGPoint, scrollWidth: CGFloat) {
        let dis = menus.getScrollDistance()
        let dx = offset.x * dis / scrollWidth
        
        if lineOriginalX == nil {
            lineOriginalX = line.frame.origin.x
        }
        
        let X = (lineOriginalX ?? 0) + dx
        let originalFrame = line.frame
        line.frame = CGRect(x: X,
                            y: originalFrame.origin.y,
                            width: originalFrame.size.width,
                            height: originalFrame.size.height)
        layoutIfNeeded()
    }
}

extension ScrollMenus: MenusViewDelegate {
    
    func menuClick(index: Int) {
        updateLineFrame()
        collectionViewModel.scrollTo(index: index)
    }
}
