//
//  SongListHeaderItem.swift
//  Duyog
//
//  Created by Mounir Ybanez on 29/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol SongListHeaderItem {

    var titleText: String { get }
    var subtitleText: String { get }
    var descriptionText: String { get }
}

protocol SongListHeaderConfig {
    
    func configure(_ item: SongListHeaderItem)
}

extension SongListHeader: SongListHeaderConfig {
    
    func configure(_ item: SongListHeaderItem) {
        titleLabel.text = item.titleText
        subtitleLabel.text = item.subtitleText
        descriptionLabel.text = item.descriptionText
        
        setNeedsLayout()
        layoutIfNeeded()
    }
}

struct SongListHeaderDisplayItem: SongListHeaderItem {
    
    var titleText: String
    var subtitleText: String
    var descriptionText: String
    
    init() {
        titleText = ""
        subtitleText = ""
        descriptionText = ""
    }
}
