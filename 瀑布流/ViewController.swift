//
//  ViewController.swift
//  瀑布流
//
//  Created by Bill on 2017/5/11.
//  Copyright © 2017年 Bill. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let kCollectionViewCellID = "CollectionViewCellID"
    
    fileprivate lazy var collectionView : UICollectionView = {
        
        let waterfallLayout = YTWaterfallLayout()
        waterfallLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        waterfallLayout.minimumLineSpacing = 10
        waterfallLayout.minimumInteritemSpacing = 10
        waterfallLayout.dataSource = self
        
        let collection : UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: waterfallLayout)
        collection.delegate = self
        collection.dataSource = self
    
        return collection;
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCollectionViewCellID)

    }

}

extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellID, for: indexPath)
        cell.backgroundColor = UIColor.randomRGB()
        return cell
    }
    
}

extension ViewController :UICollectionViewDelegate {
    
}

extension ViewController : YTWaterfallLayoutDataSource {
    /// 取每个item的高度
    func waterfallLayout(_ waterLayout: YTWaterfallLayout, heightForItem: Int) -> CGFloat {
        return CGFloat(arc4random_uniform(150) + 100)
    }

    func numberOfClos(_ waterLayout: YTWaterfallLayout) -> Int {
        return 3
    }
}
