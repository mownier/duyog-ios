//
//  MusicPlayerTrackViewItem.swift
//  Duyog
//
//  Created by Mounir Ybanez on 30/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol MusicPlayerTrackViewConfig {
    
    func configure(durationText: String)
    func configure(elapsedText: String, progress: Float)
}

extension MusicPlayerTrackView: MusicPlayerTrackViewConfig {
    
    func configure(durationText: String) {
        endLabel.text = durationText
    }
    
    func configure(elapsedText: String, progress: Float) {
        startLabel.text = elapsedText
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.slider.setValue(progress, animated: true)
        }) { _ in }
    }
}
