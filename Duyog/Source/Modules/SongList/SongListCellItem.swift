//
//  SongListCellItem.swift
//  Duyog
//
//  Created by Mounir Ybanez on 29/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol SongListCellItem {

    var titleText: String { get }
}

protocol SongListCellConfig {
    
    var dynamicHeight: CGFloat { get }
    
    func configure(_ item: SongListCellItem)
}

extension SongListCell: SongListCellConfig {
    
    var dynamicHeight: CGFloat {
        return max(titleLabel.frame.maxY, playButton.frame.maxY) + 16
    }
    
    func configure(_ item: SongListCellItem) {
        titleLabel.text = item.titleText
        
        setNeedsLayout()
        layoutIfNeeded()
    }
}

struct SongListCellDisplayItem: SongListCellItem {
    
    var titleText: String
    
    init() {
        titleText = ""
    }
}
