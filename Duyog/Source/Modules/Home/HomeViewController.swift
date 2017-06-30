//
//  HomeViewController.swift
//  Duyog
//
//  Created by Mounir Ybanez on 28/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var navigationTitleLabel: UILabel?
    var header: HomeHeader!
    var flowLayout: UICollectionViewFlowLayout!
    var collectionView: UICollectionView!
    var contentItems: [HomeContentViewItem] = []
    
    
    override func loadView() {
        super.loadView()
        
        var theme = UITheme()
        
        view.backgroundColor = theme.color.black
        
        header = HomeHeader()
        
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 12
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.contentInset.top = 228
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        
        view.addSubview(header)
        view.addSubview(collectionView)
        
        HomeCell.register(in: collectionView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItem()
        
        var item = HomeContentViewDisplayItem()
        var cellItem = HomeContentCellDisplayItem()
        
        item.headerTitleText = "POPULAR ARTISTS"
        
        cellItem.titleText = "Beyonce"
        cellItem.subtitleText = "195 Songs"
        item.cellItems.append(cellItem)
        
        cellItem.titleText = "Eminem"
        cellItem.subtitleText = "296 Songs"
        item.cellItems.append(cellItem)
        
        cellItem.titleText = "Lady Gaga"
        cellItem.subtitleText = "98 Songs"
        item.cellItems.append(cellItem)
        
        cellItem.titleText = "Britney Spears"
        cellItem.subtitleText = "237 Songs"
        item.cellItems.append(cellItem)
        
        contentItems.append(item)
        contentItems.append(item)
        contentItems.append(item)
        contentItems.append(item)
    }
    
    func setupNavigationItem() {
        guard navigationController != nil else { return }
        
        var theme = UITheme()
        let attributedText = NSAttributedString(
            string: "HOME",
            attributes: [
                NSKernAttributeName: 2,
                NSFontAttributeName: theme.font.regular(11),
                NSForegroundColorAttributeName: UIColor.white
            ]
        )
        navigationTitleLabel = UILabel()
        navigationTitleLabel?.textAlignment = .center
        navigationTitleLabel?.attributedText = attributedText
        navigationItem.titleView = navigationTitleLabel
        
        var barItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_menu"), style: .plain, target: self, action: #selector(self.didTapMenu))
        navigationItem.leftBarButtonItem = barItem
        
        barItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_search"), style: .plain, target: self, action: #selector(self.didTapSearch))
        navigationItem.rightBarButtonItem = barItem
    }
    
    override func viewDidLayoutSubviews() {
        var rect = CGRect.zero
        
        if let nav = navigationController {
            rect.size.height = nav.navigationBar.frame.height
            navigationTitleLabel?.frame = rect
        }
        
        rect.origin = .zero
        rect.size.width = view.frame.width
        rect.size.height = 208
        header.frame = rect
        
        rect.size.height = view.frame.height
        collectionView.frame = rect
        
        flowLayout.itemSize.width = rect.width
        flowLayout.itemSize.height = 188
        collectionView.reloadData()
    }
    
    func didTapMenu() {
        
    }
    
    func didTapSearch() {
        var item = SongListViewDisplayItem()
        var headerItem = item.headerItem as! SongListHeaderDisplayItem
        headerItem.descriptionText = "Coldpay is a British rock band formed in 1996 by lead vocalist and keyboardist Chris Martin"
        headerItem.titleText = "Coldplay"
        headerItem.subtitleText = "ALTERNATIVE ROCK"
        item.headerItem = headerItem
        
        var cellItem = SongListCellDisplayItem()
        cellItem.titleText = "A Head Full of Dreams"
        item.cellItems.append(cellItem)
        cellItem.titleText = "A Whisper"
        item.cellItems.append(cellItem)
        cellItem.titleText = "Amsterdam"
        item.cellItems.append(cellItem)
        cellItem.titleText = "Always In My Head"
        item.cellItems.append(cellItem)
        cellItem.titleText = "Careful Where You Go"
        item.cellItems.append(cellItem)
        
        let vc = SongListViewController()
        vc.title = "ARTIST"
        vc.item = item
        
        navigationController?.pushViewController(vc, animated: true)
    }

    func embedInNavigationController() -> UINavigationController {
        let nav = UINavigationController(rootViewController: self)
        nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav.navigationBar.shadowImage = UIImage()
        nav.navigationBar.isTranslucent = true
        nav.navigationBar.tintColor = UIColor.white
        return nav
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = HomeCell.dequeue(from: collectionView, at: indexPath)
        let item = contentItems[indexPath.row]
        cell.content.item = item
        return cell
    }
}
