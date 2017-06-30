//
//  MusicPlayerTrackView.swift
//  Duyog
//
//  Created by Mounir Ybanez on 30/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class MusicPlayerTrackView: UIView {

    var slider: UISlider!
    var startLabel: UILabel!
    var endLabel: UILabel!
    
    convenience init() {
        self.init(frame: .zero)
        initSetup()
    }
    
    override func layoutSubviews() {
        var rect = CGRect.zero
        
        let previousSliderWidth = slider.frame.width
        
        rect.size.width = frame.width
        rect.size.height = 2
        slider.frame = rect
        
        if previousSliderWidth != rect.width && rect.width > 0 {
            var theme = UITheme()
            let maxTrackView = UIView()
            maxTrackView.frame.size = rect.size
            maxTrackView.backgroundColor = theme.color.gray.withAlphaComponent(0.4)
            if let image = maxTrackView.contextualImage {
                slider.setMaximumTrackImage(image, for: .normal)
            }
            
            let minTrackView = GradientView()
            minTrackView.frame.size = rect.size
            minTrackView.gradientLayer.colors = [theme.color.pink.cgColor, theme.color.violet.cgColor]
            minTrackView.gradientLayer.gradient = GradientPoint.rightLeft.draw()
            if let image = minTrackView.contextualImage {
                slider.setMinimumTrackImage(image, for: .normal)
            }
        }
        
        rect.origin.y = rect.maxY + 16
        rect.size.width = rect.width / 2
        rect.size.height = startLabel.sizeThatFits(rect.size).height
        startLabel.frame = rect
        
        rect.origin.x = rect.maxX
        rect.size.height = endLabel.sizeThatFits(rect.size).height
        endLabel.frame = rect
    }
    
    func initSetup() {
        var theme = UITheme()
        
        slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.isUserInteractionEnabled = false
        slider.setThumbImage(#imageLiteral(resourceName: "knob"), for: .normal)
        
        startLabel = UILabel()
        startLabel.textColor = theme.color.gray
        startLabel.font = theme.font.regular(10)
        
        endLabel = UILabel()
        endLabel.textColor = theme.color.gray
        endLabel.font = theme.font.regular(10)
        endLabel.textAlignment = .right
        
        addSubview(slider)
        addSubview(startLabel)
        addSubview(endLabel)
    }
}
