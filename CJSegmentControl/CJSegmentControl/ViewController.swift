//
//  ViewController.swift
//  CJSegmentControl
//
//  Created by CoderJon on 2017/7/7.
//  Copyright © 2017年 CoderJon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        //        let titles = ["推荐", "手游", "娱乐", "美女", "颜值"]
        let titles = ["最新", "内涵段子", "轻松一刻", "电视台", "邮箱", "数码", "房产", "教育"]
        let style = CJTitleStyle()
        style.isScrollEnable = true
        style.isShowScrollLine = true
        
        var childVcs = [UIViewController]()
        for _ in 0..<titles.count {
            let vc = UIViewController()
            childVcs.append(vc)
        }
        
        let pageFrame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64)
        
        let pageView = CJPageView(frame: pageFrame, titles: titles, childVcs: childVcs, parentVc: self, style: style)
        view.addSubview(pageView)
    }

    


}

