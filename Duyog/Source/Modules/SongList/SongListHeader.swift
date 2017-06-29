//
//  SongListHeader.swift
//  Duyog
//
//  Created by Mounir Ybanez on 29/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class SongListHeader: UIView {
    
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    var descriptionLabel: UILabel!
    
    convenience init() {
        self.init(frame: .zero)
        initSetup()
    }
    
    override func layoutSubviews() {
        var rect = CGRect.zero
        
        rect.origin.x = 20
        rect.size.width = frame.width - rect.origin.x * 2
        
        let titleBottomMargin: CGFloat = 2
        let subtitleBottomMargin: CGFloat = 8
        let titleHeight = titleLabel.sizeThatFits(rect.size).height
        let subtitleHeight = subtitleLabel.sizeThatFits(rect.size).height
        let descriptionHeight = descriptionLabel.sizeThatFits(rect.size).height
        let totalHeight = titleHeight + titleBottomMargin + subtitleHeight + subtitleBottomMargin + descriptionHeight
        
        rect.origin.y = (frame.height - totalHeight) / 2
        rect.size.height = titleHeight
        titleLabel.frame = rect
        
        rect.origin.y = rect.maxY + titleBottomMargin
        rect.size.height = subtitleHeight
        subtitleLabel.frame = rect
        
        rect.origin.y = rect.maxY + subtitleBottomMargin
        rect.size.height = descriptionHeight
        descriptionLabel.frame = rect
    }
    
    func initSetup() {
        backgroundColor = .clear
        
        var theme = UITheme()
        
        titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.font = theme.font.medium(24)
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        
        subtitleLabel = UILabel()
        subtitleLabel.textColor = .white
        subtitleLabel.font = theme.font.regular(12)
        subtitleLabel.numberOfLines = 2
        subtitleLabel.textAlignment = .center
        
        descriptionLabel = UILabel()
        descriptionLabel.textColor = .white
        descriptionLabel.font = theme.font.regular(15)
        descriptionLabel.numberOfLines = 4
        descriptionLabel.textAlignment = .center
        
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(descriptionLabel)
    }
}
