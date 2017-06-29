//
//  HomeContentCell.swift
//  Duyog
//
//  Created by Mounir Ybanez on 29/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class HomeContentCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSetup()
    }
    
    override func layoutSubviews() {
        var rect = CGRect.zero
        
        rect.size.width = min(frame.width, frame.height)
        rect.size.height = rect.width
        imageView.frame = rect
        
        rect.origin.y = rect.maxY + 4
        rect.size.height = titleLabel.sizeThatFits(rect.size).height
        titleLabel.frame = rect
        
        rect.origin.y = rect.maxY + 2
        rect.size.height = subtitleLabel.sizeThatFits(rect.size).height
        subtitleLabel.frame = rect
    }
    
    func initSetup() {
        backgroundColor = .clear
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 3
        
        var theme = UITheme()
        
        titleLabel = UILabel()
        titleLabel.textColor = UIColor.white
        titleLabel.font = theme.font.regular(14)
        
        subtitleLabel = UILabel()
        subtitleLabel.textColor = theme.color.gray
        subtitleLabel.font = theme.font.regular(11)
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }
}

extension HomeContentCell: CollectionViewReusableProtocol {
    
    typealias Cell = HomeContentCell
}
