//
//  SongListViewItem.swift
//  Duyog
//
//  Created by Mounir Ybanez on 29/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol SongListViewItem {

    var coverPhotoURLPath: String { get }
    var headerItem: SongListHeaderItem { get }
    var cellItems: [SongListCellItem] { get }
}

protocol SongListViewConfig {
    
    func configure(_ item: SongListViewItem)
}

extension SongListViewController: SongListViewConfig {
    
    func configure(_ item: SongListViewItem) {
        header.configure(item.headerItem)
        
        tableView.reloadData()
    }
}

struct SongListViewDisplayItem: SongListViewItem {
    
    var coverPhotoURLPath: String
    var headerItem: SongListHeaderItem
    var cellItems: [SongListCellItem]
    
    init() {
        coverPhotoURLPath = ""
        headerItem = SongListHeaderDisplayItem()
        cellItems = []
    }
}
