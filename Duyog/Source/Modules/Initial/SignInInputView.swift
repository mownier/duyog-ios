//
//  SignInInputView.swift
//  Duyog
//
//  Created by Mounir Ybanez on 27/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol SignInInputViewDelegate: class {
    
    func signInInputViewWillResetPassword()
}

class SignInInputView: UIView {

    var gradientView: GradientView!
    var forgotPasswordButton: UIButton!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var stripView: UIView!
    
    var isEditing: Bool {
        return emailTextField.isFirstResponder || passwordTextField.isFirstResponder
    }
    
    weak var delegate: SignInInputViewDelegate?
    
    convenience init() {
        self.init(frame: .zero)
        initSetup()
    }
    
    override func layoutSubviews() {
        var rect = CGRect.zero
        
        rect.size.width = frame.width
        rect.size.height = 104
        gradientView.frame = rect
        
        rect.size.width = gradientView.frame.width
        rect.size.height = 1
        rect.origin.y = (gradientView.frame.height - rect.height) / 2
        stripView.frame = rect
        
        rect.size.height = gradientView.frame.height / 2
        rect.origin.y = 0
        emailTextField.frame = rect
        
        rect.origin.y = rect.maxY
        passwordTextField.frame = rect
        
        rect.origin.y = gradientView.frame.maxY + 8
        rect.size.height = 26
        forgotPasswordButton.frame = rect
    }
    
    func initSetup() {
        var theme = UITheme()
        
        gradientView = GradientView()
        gradientView.layer.cornerRadius = 8
        gradientView.layer.masksToBounds = true
        gradientView.gradientLayer.colors = [theme.color.pink.cgColor, theme.color.violet.cgColor]
        gradientView.gradientLayer.gradient = GradientPoint.rightLeft.draw()
        
        var attributedText = NSAttributedString(
            string: "FORGOT YOUR PASSWORD?",
            attributes: [
                NSKernAttributeName: 3,
                NSFontAttributeName: theme.font.regular(11),
                NSForegroundColorAttributeName: theme.color.gray
            ]
        )
        
        forgotPasswordButton = UIButton()
        forgotPasswordButton.setAttributedTitle(attributedText, for: .normal)
        forgotPasswordButton.addTarget(self, action: #selector(self.didTapForgotPasswordButton), for: .touchUpInside)
    
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
        
        stripView = UIView()
        stripView.backgroundColor = theme.color.gray.withAlphaComponent(0.4)
        
        gradientView.addSubview(stripView)
        gradientView.addSubview(emailTextField)
        gradientView.addSubview(passwordTextField)
        addSubview(gradientView)
        addSubview(forgotPasswordButton)
    }
    
    func didTapForgotPasswordButton() {
        delegate?.signInInputViewWillResetPassword()
    }
}
