//
//  InitialAnimator.swift
//  Duyog
//
//  Created by Mounir Ybanez on 27/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class InitialAnimator {
    
    weak var signInView: SignInInputView!
    weak var signUpView: SignUpInputView!
    weak var passwordResetView: PasswordResetInputView!
    weak var footerLabel: UILabel!
    
    func showSignInView() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.signInView.alpha = 1
        }) { _ in }
    }
    
    func hideSignInView() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            self.signInView.alpha = 0
        }) { _ in }
    }
    
    func showSignUpView() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.signUpView.alpha = 1
        }) { _ in }
    }
    
    func hideSignUpView() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            self.signUpView.alpha = 0
        }) { _ in }
    }
    
    func showPasswordResetView() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.passwordResetView.alpha = 1
        }) { _ in }
    }
    
    func hidePasswordResetView() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            self.passwordResetView.alpha = 0
        }) { _ in }
    }
    
    func changeFooterText(_ text: String) {
        var theme = UITheme()
        let attributedText = NSAttributedString(
            string: text,
            attributes: [
                NSKernAttributeName: 3,
                NSFontAttributeName: theme.font.regular(11),
                NSForegroundColorAttributeName: theme.color.gray
            ]
        )
        
        UIView.transition(with: footerLabel, duration: 0.25, options: .transitionCrossDissolve, animations: {
            self.footerLabel.attributedText = attributedText
        }) { _ in }
    }
}
