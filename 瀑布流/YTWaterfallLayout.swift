//
//  YTCollectionViewWaterLayout.swift
//  瀑布流
//
//  Created by Bill on 2017/5/11.
//  Copyright © 2017年 Bill. All rights reserved.
//

import UIKit

protocol YTWaterfallLayoutDataSource : class {
    /// 取行数
    func numberOfClos(_ waterLayout : YTWaterfallLayout) -> Int
    /// 取每个item的高度
    func waterfallLayout(_ waterLayout : YTWaterfallLayout, heightForItem : Int ) -> CGFloat
}

class YTWaterfallLayout: UICollectionViewFlowLayout {
    
    weak var dataSource : YTWaterfallLayoutDataSource?
    fileprivate var clos : Int! {
        get {
            return self.dataSource?.numberOfClos(self) ?? 2
        }
    }
    fileprivate var cloHeights : [CGFloat]!
    fileprivate var attributes = [UICollectionViewLayoutAttributes]()
    
    // 准备阶段
    override func prepare() {
        super.prepare()
        
        cloHeights = Array(repeating: self.sectionInset.top, count: self.clos)
        let cellW = (collectionView!.frame.width - sectionInset.left - sectionInset.right - CGFloat(clos - 1) * minimumInteritemSpacing) / CGFloat(clos)
        
        let itemCount = self.collectionView!.numberOfItems(inSection: 0)
        for i in 0..<itemCount {
            
            let indexPath = IndexPath(item: i, section: 0)
            let att = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            let minCloHeight = cloHeights.min()!
            let minClo = cloHeights.index(of: minCloHeight)!
            let cellX = sectionInset.left + (minimumInteritemSpacing + cellW) * CGFloat(minClo)
            let cellY = minCloHeight + minimumLineSpacing
            
            
            guard let cellH = dataSource?.waterfallLayout(self, heightForItem: i) else {
                fatalError("必须实现waterfallItemHight, 返回高度")
            }
            
            att.frame = CGRect(x: cellX, y: cellY, width: cellW, height: cellH)
            attributes.append(att)
            
            let totalH = minCloHeight + cellH + minimumLineSpacing
            cloHeights[minClo] = totalH
        }
    }
    
// MARK: - 返回准备好的所有布局
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.attributes
    }
    
}

extension YTWaterfallLayout {
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: cloHeights.max()! + minimumLineSpacing);
    }
}
