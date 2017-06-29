//
//  SongListCell.swift
//  Duyog
//
//  Created by Mounir Ybanez on 29/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol SongListCellDelegate: class {
    
    func songListCellWillPlay(_ cell: UITableViewCell)
}

class SongListCell: UITableViewCell {
    
    var titleLabel: UILabel!
    var playButton: UIButton!
    var stripView: UIView!
    
    weak var delegate: SongListCellDelegate?
    
    convenience init() {
        self.init(style: .default, reuseIdentifier: SongListCell.reuseId)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSetup()
    }
    
    override func layoutSubviews() {
        var rect = CGRect.zero
        
        let leftInset: CGFloat = 16
        
        playButton.sizeToFit()
        rect.size = playButton.frame.size
        rect.origin.x = frame.width - leftInset - rect.width
        rect.origin.y = (frame.height - rect.height) / 2
        playButton.frame = rect
        
        rect.origin.x = leftInset
        rect.size.width = frame.width - (leftInset * 2)
        rect.size.width -= (playButton.frame.width + 4)
        rect.size.height = titleLabel.sizeThatFits(rect.size).height
        rect.origin.y = (frame.height - rect.height) / 2
        titleLabel.frame = rect
        
        rect.size.height = 1
        rect.size.width = frame.width
        rect.origin.x = 0
        rect.origin.y = frame.height - rect.height
        stripView.frame = rect
    }
    
    func initSetup() {
        selectionStyle = .none
        backgroundColor = .clear
        
        var theme = UITheme()
        
        titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.font = theme.font.regular(15)
        titleLabel.numberOfLines = 0
        
        playButton = UIButton()
        playButton.addTarget(self, action: #selector(self.didTapPlayButton), for: .touchUpInside)
        playButton.tintColor = theme.color.blue
        playButton.setImage(#imageLiteral(resourceName: "icon_line_play"), for: .normal)
        playButton.setImage(#imageLiteral(resourceName: "icon_line_play"), for: .highlighted)
        
        stripView = UIView()
        stripView.backgroundColor = theme.color.gray.withAlphaComponent(0.2)
        
        addSubview(titleLabel)
        addSubview(playButton)
        addSubview(stripView)
    }
    
    func didTapPlayButton() {
        delegate?.songListCellWillPlay(self)
    }
}

extension SongListCell: TableViewReusableProtocol {
    
    typealias Cell = SongListCell
}
