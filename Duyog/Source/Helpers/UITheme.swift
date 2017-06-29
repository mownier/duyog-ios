//
//  UITheme.swift
//  Duyog
//
//  Created by Mounir Ybanez on 26/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

struct UITheme {
    
    lazy private(set) var font: UIThemeFont = {
        return UIThemeFont()
    }()
    
    lazy private(set) var color: UIThemeColor = {
        return UIThemeColor()
    }()
}

struct UIThemeFont {
    
    func regular(_ size: CGFloat) -> UIFont {
        return UIFont(name: "OpenSans", size: size)!
    }
    
    func medium(_ size: CGFloat) -> UIFont {
        return UIFont(name: "OpenSans-Semibold", size: size)!
    }
    
    func bold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "OpenSans-Bold", size: size)!
    }
    
    func light(_ size: CGFloat) -> UIFont {
        return UIFont(name: "OpenSans-Light", size: size)!
    }
    
    func custom(_ name: String, _ size: CGFloat) -> UIFont? {
        return UIFont(name: name, size: size)
    }
}

struct UIThemeColor {
    
    var black: UIColor {
        return UIColor(red: 27/255, green: 33/255, blue: 45/255, alpha: 1)
    }
    
    var pink: UIColor {
        return UIColor(red: 241/255, green: 59/255, blue: 111/255, alpha: 1)
    }
    
    var violet: UIColor {
        return UIColor(red: 103/255, green: 56/255, blue: 155/255, alpha: 1)
    }
    
    var gray: UIColor {
        return UIColor(red: 123/255, green: 133/255, blue: 154/255, alpha: 1)
    }
    
    var blue: UIColor {
        return UIColor(red: 81/255, green: 101/255, blue: 138/255, alpha: 1)
    }
}
