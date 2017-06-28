//
//  SignUpInputView.swift
//  Duyog
//
//  Created by Mounir Ybanez on 27/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class SignUpInputView: UIView {

    var gradientView: GradientView!
    var displayNameTextField: UITextField!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var strip1View: UIView!
    var strip2View: UIView!

    var isEditing: Bool {
        return displayNameTextField.isFirstResponder || emailTextField.isFirstResponder || passwordTextField.isFirstResponder
    }
    
    convenience init() {
        self.init(frame: .zero)
        initSetup()
    }
    
    override func layoutSubviews() {
        var rect = CGRect.zero
        
        rect.size.width = frame.width
        rect.size.height = 156
        gradientView.frame = rect
        
        rect.size.width = gradientView.frame.width
        rect.size.height = 1
        rect.origin.y = 52
        strip1View.frame = rect
        
        rect.origin.y = 105
        strip2View.frame = rect
        
        rect.size.height = gradientView.frame.height / 3
        rect.origin.y = 0
        displayNameTextField.frame = rect
        
        rect.origin.y = rect.maxY
        emailTextField.frame = rect
        
        rect.origin.y = rect.maxY
        passwordTextField.frame = rect
    }
    
    func initSetup() {
        var theme = UITheme()
        
        gradientView = GradientView()
        gradientView.layer.cornerRadius = 8
        gradientView.layer.masksToBounds = true
        gradientView.gradientLayer.colors = [theme.color.pink.cgColor, theme.color.violet.cgColor]
        gradientView.gradientLayer.gradient = GradientPoint.rightLeft.draw()
        
        var attributedText = NSAttributedString(
            string: "DISPLAY NAME",
            attributes: [
                NSKernAttributeName: 3,
                NSFontAttributeName: theme.font.regular(12),
                NSForegroundColorAttributeName: UIColor.white
            ]
        )
        
        displayNameTextField = UITextField()
        displayNameTextField.tintColor = UIColor.white
        displayNameTextField.textColor = UIColor.white
        displayNameTextField.textAlignment = .center
        displayNameTextField.attributedPlaceholder = attributedText
        displayNameTextField.font = theme.font.regular(12)
        displayNameTextField.autocapitalizationType = .none
        displayNameTextField.keyboardAppearance = .dark
        displayNameTextField.returnKeyType = .next

        
        attributedText = NSAttributedString(
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
        emailTextField.returnKeyType = .next

        attributedText = NSAttributedString(
            string: "PASSWORD",
            attributes: [
                NSKernAttributeName: 3,
                NSFontAttributeName: theme.font.regular(12),
                NSForegroundColorAttributeName: UIColor.white
            ]
        )
        
        passwordTextField = UITextField()
        passwordTextField.tintColor = UIColor.white
        passwordTextField.textColor = UIColor.white
        passwordTextField.textAlignment = .center
        passwordTextField.attributedPlaceholder = attributedText
        passwordTextField.font = theme.font.regular(12)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocapitalizationType = .none
        passwordTextField.keyboardAppearance = .dark
        passwordTextField.returnKeyType = .done
        
        strip1View = UIView()
        strip1View.backgroundColor = theme.color.gray.withAlphaComponent(0.4)
        
        strip2View = UIView()
        strip2View.backgroundColor = strip1View.backgroundColor
        
        gradientView.addSubview(displayNameTextField)
        gradientView.addSubview(emailTextField)
        gradientView.addSubview(passwordTextField)
        gradientView.addSubview(strip1View)
        gradientView.addSubview(strip2View)
        addSubview(gradientView)
    }
}
