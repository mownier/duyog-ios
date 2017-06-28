//
//  PasswordResetInputView.swift
//  Duyog
//
//  Created by Mounir Ybanez on 27/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class PasswordResetInputView: GradientView {

    var emailTextField: UITextField!
    
    var isEditing: Bool {
        return emailTextField.isFirstResponder
    }
    
    convenience init() {
        self.init(frame: .zero)
        initSetup()
    }
    
    override func layoutSubviews() {
        var rect = CGRect.zero
        
        rect.size = frame.size
        emailTextField.frame = rect
    }
    
    func initSetup() {
        var theme = UITheme()
        
        layer.cornerRadius = 8
        layer.masksToBounds = true
        gradientLayer.colors = [theme.color.pink.cgColor, theme.color.violet.cgColor]
        gradientLayer.gradient = GradientPoint.rightLeft.draw()
        
        let attributedText = NSAttributedString(
            string: "EMAIL",
            attributes: [
                NSKernAttributeName: 3,
                NSFontAttributeName: theme.font.regular(12),
                NSForegroundColorAttributeName: UIColor.white
            ]
        )
        
        emailTextField = UITextField()
        emailTextField.tintColor = UIColor.white
        emailTextField.textColor = UIColor.white
        emailTextField.textAlignment = .center
        emailTextField.attributedPlaceholder = attributedText
        emailTextField.font = theme.font.regular(12)
        emailTextField.autocapitalizationType = .none
        emailTextField.keyboardAppearance = .dark
        emailTextField.returnKeyType = .done
        
        addSubview(emailTextField)
    }
}
