//
//  MusicPlayerControl.swift
//  Duyog
//
//  Created by Mounir Ybanez on 30/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol MusicPlayerControlDelegate: class {
    
    func musicPlayerControlWillShuffle()
    func musicPlayerControlWillPlayPrevious()
    func musicPlayerControlWillPlayNext()
    func musicPlayerControlWillPlayCurrent()
    func musicPlayerControlWillConfigureSounds()
}

class MusicPlayerControl: UIView {

    var shuffleButton: UIButton!
    var previousButton: UIButton!
    var nextButton: UIButton!
    var playButton: UIButton!
    var soundsButton: UIButton!
    
    weak var delegate: MusicPlayerControlDelegate?
    
    convenience init() {
        self.init(frame: .zero)
        initSetup()
    }
    
    override func layoutSubviews() {
        var rect = CGRect.zero
        
        shuffleButton.sizeToFit()
        previousButton.sizeToFit()
        nextButton.sizeToFit()
        soundsButton.sizeToFit()
        playButton.sizeToFit()
        
        let inset: CGFloat = 8
        let playButtonLeftMargin: CGFloat = 16
        let shuffleButtonWidth = shuffleButton.bounds.width + inset * 2
        let previousButtonWidth = previousButton.bounds.width + inset * 2
        let nextButtonWidth = nextButton.bounds.width + inset * 2
        let soundsButtonWidth = soundsButton.bounds.width + inset * 2
        let playButtonWidth = playButton.bounds.width + inset * 2
        let playButtonHeight = playButton.bounds.height + inset * 2
        
        rect.size.width = shuffleButtonWidth
        rect.size.height = rect.width
        rect.origin.y = (frame.height - rect.height) / 2
        rect.origin.x = 0
        shuffleButton.frame = rect
        
        rect.size.width = soundsButtonWidth
        rect.size.height = rect.width
        rect.origin.y = (frame.height - rect.height) / 2
        rect.origin.x = frame.width - rect.width
        soundsButton.frame = rect
        
        rect.size.width = playButtonWidth
        rect.size.height = playButtonHeight
        rect.origin.x = (frame.width - rect.width) / 2
        rect.origin.y = (frame.height - rect.height) / 2
        playButton.frame = rect
        
        rect.size.width = previousButtonWidth
        rect.size.height = rect.width
        rect.origin.y = (frame.height - rect.height) / 2
        rect.origin.x = playButton.frame.origin.x - rect.width - playButtonLeftMargin
        previousButton.frame = rect
        
        rect.size.width = nextButtonWidth
        rect.size.height = rect.width
        rect.origin.y = (frame.height - rect.height) / 2
        rect.origin.x = playButton.frame.maxX + playButtonLeftMargin
        nextButton.frame = rect
    }
    
    func initSetup() {
        backgroundColor = .clear
        
        var theme = UITheme()
        
        shuffleButton = UIButton()
        shuffleButton.tintColor = theme.color.gray
        shuffleButton.setImage(#imageLiteral(resourceName: "icon_shuffle"), for: .normal)
        shuffleButton.setImage(#imageLiteral(resourceName: "icon_shuffle"), for: .highlighted)
        shuffleButton.addTarget(self, action: #selector(self.didTapShuffleButton), for: .touchUpInside)
        
        previousButton = UIButton()
        previousButton.tintColor = .white
        previousButton.setImage(#imageLiteral(resourceName: "icon_previous"), for: .normal)
        previousButton.setImage(#imageLiteral(resourceName: "icon_previous"), for: .highlighted)
        previousButton.addTarget(self, action: #selector(self.didTapPreviousButton), for: .touchUpInside)
        
        nextButton = UIButton()
        nextButton.tintColor = .white
        nextButton.setImage(#imageLiteral(resourceName: "icon_next"), for: .normal)
        nextButton.setImage(#imageLiteral(resourceName: "icon_next"), for: .highlighted)
        nextButton.addTarget(self, action: #selector(self.didTapNextButton), for: .touchUpInside)
        
        soundsButton = UIButton()
        soundsButton.tintColor = theme.color.gray
        soundsButton.setImage(#imageLiteral(resourceName: "icon_sounds"), for: .normal)
        soundsButton.setImage(#imageLiteral(resourceName: "icon_sounds"), for: .highlighted)
        soundsButton.addTarget(self, action: #selector(self.didTapSoundsButton), for: .touchUpInside)
        
        playButton = GradientButton()
        playButton.contentMode = .center
        playButton.gradientLayer.colors = [theme.color.pink.withAlphaComponent(0.5).cgColor, theme.color.violet.withAlphaComponent(0.5).cgColor]
        playButton.gradientLayer.gradient = GradientPoint.bottomRightTopLeft.draw()
        playButton.addTarget(self, action: #selector(self.didTapPlayButton), for: .touchUpInside)
        
        addSubview(shuffleButton)
        addSubview(previousButton)
        addSubview(nextButton)
        addSubview(soundsButton)
        addSubview(playButton)
    }
    
    func didTapPlayButton() {
        delegate?.musicPlayerControlWillPlayCurrent()
    }
    
    func didTapShuffleButton() {
        delegate?.musicPlayerControlWillShuffle()
    }
    
    func didTapNextButton() {
        delegate?.musicPlayerControlWillPlayNext()
    }
    
    func didTapPreviousButton() {
        delegate?.musicPlayerControlWillPlayPrevious()
    }
    
    func didTapSoundsButton() {
        delegate?.musicPlayerControlWillConfigureSounds()
    }
}
