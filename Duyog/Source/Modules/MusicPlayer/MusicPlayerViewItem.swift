//
//  MusicPlayerViewItem.swift
//  Duyog
//
//  Created by Mounir Ybanez on 30/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol MusicPlayerViewItem {

    var trackItem: MusicPlayerTrackViewItem { get }
}

protocol MusicPlayerViewConfig {
    
    func configure(_ item: MusicPlayerViewItem)
}

extension MusicPlayerViewController: MusicPlayerViewConfig {
    
    func configure(_ item: MusicPlayerViewItem) {
        trackView.configure(item.trackItem)
    }
}

struct MusicPlayerViewDisplayItem: MusicPlayerViewItem {
    
    var trackItem: MusicPlayerTrackViewItem
    
    init() {
        trackItem = MusicPlayerTrackViewDisplayItem()
    }
}
