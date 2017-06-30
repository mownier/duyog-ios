//
//  MusicPlayerControlConfig.swift
//  Duyog
//
//  Created by Mounir Ybanez on 30/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

enum MusicPlayerControlState {
    
    case play
    case pause
}

protocol MusicPlayerControlConfig {

    func configure(_ state: MusicPlayerControlState)
}

extension MusicPlayerControl: MusicPlayerControlConfig {
    
    func configure(_ state: MusicPlayerControlState) {
        let image: UIImage
        
        switch state {
        case .play: image = #imageLiteral(resourceName: "mask_pause")
        case .pause: image = #imageLiteral(resourceName: "mask_play")
        }
        
        let maskView = UIImageView(image: image)
        maskView.contentMode = .scaleAspectFit
        maskView.frame.size = playButton.frame.size
        playButton.mask = maskView
    }
}
