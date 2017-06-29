//
//  HomeContentViewController.swift
//  Duyog
//
//  Created by Mounir Ybanez on 29/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class HomeContentViewController: UIViewController {

    var collectionView: UICollectionView!
    var headerTitleLabel: UILabel!
    var flowLayout: UICollectionViewFlowLayout!
    
    var item: HomeContentViewItem! {
        didSet {
            guard isViewLoaded else { return }
            
            configure(item)
        }
    }
    
    override func loadView() {
        super.loadView()
        
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 12
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.contentInset.left = 24
        collectionView.contentInset.right = 24
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        
        headerTitleLabel = UILabel()
        headerTitleLabel.textColor = .white
        
        view.addSubview(collectionView)
        view.addSubview(headerTitleLabel)
    
        HomeContentCell.register(in: collectionView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if item != nil {
            configure(item)
        }
    }
    
    override func viewDidLayoutSubviews() {
        var rect = CGRect.zero
        
        rect.origin.x = collectionView.contentInset.left
        rect.size.width = view.frame.width - rect.origin.x * 2
        rect.size.height = headerTitleLabel.sizeThatFits(rect.size).height
        headerTitleLabel.frame = rect
        
        rect.origin.y = rect.maxY + 16
        rect.size.height = 172
        rect.origin.x = 0
        rect.size.width = view.frame.width
        collectionView.frame = rect
        
        flowLayout.itemSize.height = rect.height
        flowLayout.itemSize.width = 94
        collectionView.reloadData()
    }
}

extension HomeContentViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item.cellItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = HomeContentCell.dequeue(from: collectionView, at: indexPath)
        let cellItem = item.cellItems[indexPath.row]
        cell.configure(cellItem)
        return cell
    }
}

