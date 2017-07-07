//
//  CJContentView.swift
//  Demo
//
//  Created by CoderJon on 2017/7/4.
//  Copyright © 2017年 CoderJon. All rights reserved.
//

import UIKit

private let kContentCellID = "ContentCellID"

protocol CJContentViewDelegate: class {
    func contentView(_ contentView: CJContentView, targetIndex: Int)
    func contentView(_ contentView: CJContentView, targetIndex: Int, progress: CGFloat)
}

class CJContentView: UIView {
    weak var delegate: CJContentViewDelegate?
    fileprivate var childVcs: [UIViewController]
    fileprivate var parentVc: UIViewController
    fileprivate var startOffsetX: CGFloat = 0
    fileprivate var isForbidScrol: Bool = false
    
    fileprivate lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
        
        return collectionView
    }()
 
    
    init(frame: CGRect, childVcs: [UIViewController], parentVc: UIViewController) {
        self.childVcs = childVcs
        self.parentVc = parentVc
        super.init(frame: frame)
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CJContentView{
    fileprivate func setupUI(){
        
        for childVc in childVcs {
            parentVc.addChildViewController(childVc)
        }
        
        addSubview(collectionView)
    }
}

//MARK: - UICollectionViewDataSource
extension CJContentView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath)
        
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        cell.backgroundColor = UIColor.randomColor()
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension CJContentView: UICollectionViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        contentEndScroll()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            contentEndScroll()
        }
    }
    
    private func contentEndScroll(){
        
        guard !isForbidScrol else {
            return
        }
        
        let currentIndex = Int(collectionView.contentOffset.x / collectionView.bounds.width)
        //delegate
        delegate?.contentView(self, targetIndex: currentIndex)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrol = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !isForbidScrol else {
            return
        }
        
        guard startOffsetX != scrollView.contentOffset.x else {
            return
        }
        
        var targetIndex = 0
        var progress: CGFloat = 0
        
        let currentIndex = Int(startOffsetX/scrollView.bounds.width)
        
        //considering the system sometimes broken sliding around, sometimes will move a little
        if startOffsetX < scrollView.contentOffset.x {//left
            targetIndex = targetIndex > childVcs.count - 1 ? childVcs.count - 1 : currentIndex + 1
            
            progress = (scrollView.contentOffset.x - startOffsetX)/scrollView.bounds.width
        } else{ //right
            targetIndex = targetIndex < 0 ? 0 : currentIndex - 1
            progress = (startOffsetX - scrollView.contentOffset.x)/scrollView.bounds.width
        }
        
        delegate?.contentView(self, targetIndex: targetIndex, progress: progress)
    }
}

//MARK: - CJTitleViewDelegate
extension CJContentView: CJTitleViewDelegate{
    func titleView(_ titleView: CJTitleView, targetIndex: Int) {
        isForbidScrol = true
        let indexPath = IndexPath(item: targetIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
}
