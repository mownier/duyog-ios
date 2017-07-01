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
    var songTitleText: String { get }
    var artistText: String { get }
}

protocol MusicPlayerViewConfig {
    
    func configure(_ item: MusicPlayerViewItem)
}

extension MusicPlayerViewController: MusicPlayerViewConfig {
    
    func configure(_ item: MusicPlayerViewItem) {
        trackView.configure(item.trackItem)
        songTitleLabel.text = item.songTitleText
        artistLabel.text = item.artistText
    }
}

struct MusicPlayerViewDisplayItem: MusicPlayerViewItem {
    
    var trackItem: MusicPlayerTrackViewItem
    var songTitleText: String
    var artistText: String
    
    init() {
        trackItem = MusicPlayerTrackViewDisplayItem()
        songTitleText = "A Head Full Of Dreams"
        artistText = "Coldplay"
    }
}
