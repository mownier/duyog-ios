//
//  MusicPlayerControl.swift
//  Duyog
//
//  Created by Mounir Ybanez on 30/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol MusicPlayerControlDelegate: class {
    
    func musicPlayerControlWillRepeat()
    func musicPlayerControlWillPlayPrevious()
    func musicPlayerControlWillPlayNext()
    func musicPlayerControlWillPlayCurrent()
    func musicPlayerControlWillShuffle()
}

class MusicPlayerControl: UIView {

    var repeatButton: UIButton!
    var previousButton: UIButton!
    var nextButton: UIButton!
    var playButton: UIButton!
    var shuffleButton: UIButton!
    var minSoundButton: UIButton!
    var maxSoundButton: UIButton!
    var soundSlider: UISlider!
    
    weak var delegate: MusicPlayerControlDelegate?
    
    convenience init() {
        self.init(frame: .zero)
        initSetup()
    }
    
    override func layoutSubviews() {
        var rect = CGRect.zero
        
        repeatButton.sizeToFit()
        previousButton.sizeToFit()
        nextButton.sizeToFit()
        shuffleButton.sizeToFit()
        playButton.sizeToFit()
        minSoundButton.sizeToFit()
        maxSoundButton.sizeToFit()
        
        let inset: CGFloat = 8
        let playButtonLeftMargin: CGFloat = 16
        let repeatButtonWidth = repeatButton.bounds.width + inset * 2
        let previousButtonWidth = previousButton.bounds.width + inset * 2
        let nextButtonWidth = nextButton.bounds.width + inset * 2
        let shuffleButtonWidth = shuffleButton.bounds.width + inset * 2
        let playButtonWidth = playButton.bounds.width + inset * 2
        let playButtonHeight = playButton.bounds.height + inset * 2
        let minSoundButtonWidth = minSoundButton.bounds.width + inset * 2
        let maxSoundButtonWidth = maxSoundButton.bounds.width + inset * 2
        
        rect.size.width = repeatButtonWidth
        rect.size.height = rect.width
        rect.origin.y = (frame.height - rect.height) / 2
        rect.origin.x = 0
        repeatButton.frame = rect
        
        rect.size.width = shuffleButtonWidth
        rect.size.height = rect.width
        rect.origin.y = (frame.height - rect.height) / 2
        rect.origin.x = frame.width - rect.width
        shuffleButton.frame = rect
        
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
        
        rect.origin.x = repeatButton.frame.origin.x
        rect.origin.y = playButton.frame.maxY + 8
        rect.size.width = max(minSoundButtonWidth, maxSoundButtonWidth)
        rect.size.height = rect.width
        minSoundButton.frame = rect
        
        rect.origin.x = frame.width - rect.width
        maxSoundButton.frame = rect
        
        rect.size.width = frame.width - rect.width * 2 - 2 * 2
        rect.origin.x = minSoundButton.frame.maxX + 2
        rect.size.height = 20
        rect.origin.y = (minSoundButton.frame.maxY - rect.height + minSoundButton.frame.origin.y) / 2
        soundSlider.frame = rect
    }
    
    func initSetup() {
        backgroundColor = .clear
        
        var theme = UITheme()
        
        repeatButton = UIButton()
        repeatButton.tintColor = theme.color.gray
        repeatButton.setImage(#imageLiteral(resourceName: "icon_repeat"), for: .normal)
        repeatButton.setImage(#imageLiteral(resourceName: "icon_repeat"), for: .highlighted)
        repeatButton.addTarget(self, action: #selector(self.didTapRepeatButton), for: .touchUpInside)
        
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
        
        shuffleButton = UIButton()
        shuffleButton.tintColor = theme.color.gray
        shuffleButton.setImage(#imageLiteral(resourceName: "icon_shuffle"), for: .normal)
        shuffleButton.setImage(#imageLiteral(resourceName: "icon_shuffle"), for: .highlighted)
        shuffleButton.addTarget(self, action: #selector(self.didTapShuffleButton), for: .touchUpInside)
        
        playButton = GradientButton()
        playButton.contentMode = .center
        playButton.gradientLayer.colors = [theme.color.pink.withAlphaComponent(0.5).cgColor, theme.color.violet.withAlphaComponent(0.5).cgColor]
        playButton.gradientLayer.gradient = GradientPoint.bottomRightTopLeft.draw()
        playButton.addTarget(self, action: #selector(self.didTapPlayButton), for: .touchUpInside)
        
        minSoundButton = UIButton()
        minSoundButton.tintColor = theme.color.gray
        minSoundButton.setImage(#imageLiteral(resourceName: "icon_mute"), for: .normal)
        minSoundButton.setImage(#imageLiteral(resourceName: "icon_mute"), for: .highlighted)
        
        maxSoundButton = UIButton()
        maxSoundButton.tintColor = theme.color.gray
        maxSoundButton.setImage(#imageLiteral(resourceName: "icon_sounds"), for: .normal)
        maxSoundButton.setImage(#imageLiteral(resourceName: "icon_sounds"), for: .highlighted)
        
        soundSlider = UISlider()
        soundSlider.tintColor = theme.color.gray
        soundSlider.minimumValue = 0
        soundSlider.maximumValue = 1
        soundSlider.maximumTrackTintColor = theme.color.gray.withAlphaComponent(0.2)
        soundSlider.minimumTrackTintColor = theme.color.gray
        soundSlider.setThumbImage(#imageLiteral(resourceName: "thumb_sound_slider"), for: .normal)
        
        addSubview(repeatButton)
        addSubview(previousButton)
        addSubview(nextButton)
        addSubview(shuffleButton)
        addSubview(playButton)
        addSubview(minSoundButton)
        addSubview(maxSoundButton)
        addSubview(soundSlider)
    }
    
    func didTapPlayButton() {
        delegate?.musicPlayerControlWillPlayCurrent()
    }
    
    func didTapRepeatButton() {
        delegate?.musicPlayerControlWillRepeat()
    }
    
    func didTapNextButton() {
        delegate?.musicPlayerControlWillPlayNext()
    }
    
    func didTapPreviousButton() {
        delegate?.musicPlayerControlWillPlayPrevious()
    }
    
    func didTapShuffleButton() {
        delegate?.musicPlayerControlWillShuffle()
    }
}
