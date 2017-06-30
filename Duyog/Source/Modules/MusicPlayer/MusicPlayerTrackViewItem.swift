//
//  MusicPlayerTrackViewItem.swift
//  Duyog
//
//  Created by Mounir Ybanez on 30/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol MusicPlayerTrackViewItem {

    var durationText: String { get }
    var elapsedText: String { get }
    var progress: Float { get }
}

protocol MusicPlayerTrackViewConfig {
    
    func configure(_ item: MusicPlayerTrackViewItem)
    func configure(elapsedText: String, progress: Float)
}

extension MusicPlayerTrackView: MusicPlayerTrackViewConfig {
    
    func configure(_ item: MusicPlayerTrackViewItem) {
        endLabel.text = item.durationText
        configure(elapsedText: item.elapsedText, progress: item.progress)
    }
    
    func configure(elapsedText: String, progress: Float) {
        startLabel.text = elapsedText
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.slider.setValue(progress, animated: true)
        }) { _ in }
    }
}

struct MusicPlayerTrackViewDisplayItem: MusicPlayerTrackViewItem {
    
    var durationText: String
    var elapsedText: String
    var progress: Float
    
    init() {
        durationText = "0:00"
        elapsedText = "0:00"
        progress = 0
    }
}
