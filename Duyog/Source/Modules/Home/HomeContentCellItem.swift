//
//  HomeContentCellItem.swift
//  Duyog
//
//  Created by Mounir Ybanez on 29/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol HomeContentCellItem {

    var imageURLPath: String { get }
    var titleText: String { get }
    var subtitleText: String { get }
}

protocol HomeContentCellConfig {
    
    func configure(_ item: HomeContentCellItem)
}

extension HomeContentCell: HomeContentCellConfig {
    
    func configure(_ item: HomeContentCellItem) {
        var theme = UITheme()
        
        imageView.backgroundColor = theme.color.gray
        
        var attributedText = NSAttributedString(
            string: item.titleText,
            attributes: [
                NSKernAttributeName: 1,
                NSFontAttributeName: theme.font.medium(12),
                NSForegroundColorAttributeName: UIColor.white
            ]
        )
        
        titleLabel.attributedText = attributedText
        
        attributedText = NSAttributedString(
            string: item.subtitleText,
            attributes: [
                NSKernAttributeName: 1,
                NSFontAttributeName: theme.font.regular(11),
                NSForegroundColorAttributeName: theme.color.gray
            ]
        )
        
        subtitleLabel.attributedText = attributedText
        
        setNeedsLayout()
        layoutIfNeeded()
    }
}

struct HomeContentCellDisplayItem: HomeContentCellItem {
    
    var imageURLPath: String
    var titleText: String
    var subtitleText: String
    
    init() {
        imageURLPath = ""
        titleText = ""
        subtitleText = ""
    }
}
