//
//  HomeContentViewItem.swift
//  Duyog
//
//  Created by Mounir Ybanez on 29/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol HomeContentViewItem {
    
    var headerTitleText: String { get }
    var cellItems: [HomeContentCellItem] { get }
}


protocol HomeContentViewConfig {

    func configure(_ item: HomeContentViewItem)
}

extension HomeContentViewController: HomeContentViewConfig {
    
    func configure(_ item: HomeContentViewItem) {
        var theme = UITheme()
        
        let attributedText = NSAttributedString(
            string: item.headerTitleText,
            attributes: [
                NSKernAttributeName: 2,
                NSFontAttributeName: theme.font.regular(11),
                NSForegroundColorAttributeName: UIColor.white
            ]
        )
        
        headerTitleLabel.attributedText = attributedText
        
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}

struct HomeContentViewDisplayItem: HomeContentViewItem {
    
    var headerTitleText: String
    var cellItems: [HomeContentCellItem]
    
    init() {
        headerTitleText = ""
        cellItems = []
    }
}
