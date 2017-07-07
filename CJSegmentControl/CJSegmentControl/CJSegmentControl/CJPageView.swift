//
//  CJPageView.swift
//  Demo
//
//  Created by CoderJon on 2017/7/4.
//  Copyright © 2017年 CoderJon. All rights reserved.
//

import UIKit

class CJPageView: UIView {
    fileprivate var titles: [String]
    fileprivate var childVcs: [UIViewController]
    fileprivate var parentVc: UIViewController
    fileprivate var style: CJTitleStyle
    fileprivate var titleView: CJTitleView!
    
    init(frame: CGRect, titles: [String], childVcs: [UIViewController], parentVc: UIViewController, style: CJTitleStyle) {
        self.titles = titles
        self.childVcs = childVcs
        self.parentVc = parentVc
        self.style = style
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - setui
extension CJPageView{
    fileprivate func setupUI(){
        setupTitleView()
        setupContentView()
    }
    
    private func setupTitleView(){
        let titleFrame = CGRect(x: 0, y: 0, width: bounds.width, height: style.titleHeight)
        
        titleView = CJTitleView(frame: titleFrame, titles: titles, style: style)
        addSubview(titleView)
    }
    
    private func setupContentView(){
        let contentFrame = CGRect(x: 0, y: style.titleHeight, width: bounds.width, height: bounds.height - style.titleHeight)
        
        let contentView = CJContentView(frame: contentFrame, childVcs: childVcs, parentVc: parentVc)
        addSubview(contentView)
        contentView.backgroundColor = UIColor.gray
        
        //delegate
        titleView.delegate = contentView
        contentView.delegate = titleView
    }
}



