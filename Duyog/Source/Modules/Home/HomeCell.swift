//
//  HomeCell.swift
//  Duyog
//
//  Created by Mounir Ybanez on 29/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    var content: HomeContentViewController!
    
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
        
        rect.size.width = frame.width
        rect.size.height = frame.height
        content.view.frame = rect
    }
    
    func initSetup() {
        content = HomeContentViewController()
        
        addSubview(content.view)
    }
}

extension HomeCell: CollectionViewReusableProtocol {
    
    typealias Cell = HomeCell
}
