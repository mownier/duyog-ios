//
//  HomeHeader.swift
//  Duyog
//
//  Created by Mounir Ybanez on 28/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class HomeHeader: UIView {

    var gradientView: GradientView!
    var gradientView2: GradientView!
    
    convenience init() {
        self.init(frame: .zero)
        initSetup()
    }
    
    override func layoutSubviews() {
        var rect = CGRect.zero
        
        rect.origin = .zero
        rect.size.width = frame.width
        rect.size.height = 188
        gradientView.frame = rect
        
        rect.size.height = 208
        gradientView2.frame = rect
    }
    func initSetup() {
        var theme = UITheme()
        
        gradientView = GradientView()
        gradientView.gradientLayer.colors = [theme.color.pink.withAlphaComponent(0.5).cgColor, theme.color.violet.withAlphaComponent(0.5).cgColor]
        gradientView.gradientLayer.gradient = GradientPoint.rightLeft.draw()
        
        var maskView = UIImageView(image: #imageLiteral(resourceName: "wave"))
        maskView.contentMode = .scaleAspectFill
        gradientView.mask = maskView
        
        gradientView2 = GradientView()
        gradientView2.gradientLayer.colors = [theme.color.pink.withAlphaComponent(0.5).cgColor, theme.color.violet.withAlphaComponent(0.5).cgColor]
        gradientView2.gradientLayer.gradient = GradientPoint.rightLeft.draw()
        
        maskView = UIImageView(image: #imageLiteral(resourceName: "wave2"))
        maskView.contentMode = .scaleAspectFill
        gradientView2.mask = maskView
        
        addSubview(gradientView2)
        addSubview(gradientView)
    }

}
