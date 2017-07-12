//
//  MusicPlayerViewItem.swift
//  Duyog
//
//  Created by Mounir Ybanez on 30/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol MusicPlayerViewConfig {
    
    func configure(_ item: Song.Display.Item)
}

extension MusicPlayerViewController: MusicPlayerViewConfig {
    
    func configure(_ item: Song.Display.Item) {
        trackView.configure(durationText: item.song.durationText)
        songTitleLabel.text = item.song.titleText
        artistLabel.text = item.artists.count > 0 ? item.artists[0].nameText : ""
    }
}
