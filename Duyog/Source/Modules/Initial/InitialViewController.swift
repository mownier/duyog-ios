//
//  InitialViewController.swift
//  Duyog
//
//  Created by Mounir Ybanez on 27/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

enum InitialViewControllerState {
    
    case signIn
    case signUp
    case passwordReset
    
    var footerText: String {
        switch self {
        case .signIn, .passwordReset: return "DON'T HAVE AN ACCOUNT?"
        case .signUp: return "ALREADY HAVE AN ACCOUNT?"
        }
    }
}

class InitialViewController: UIViewController {

    var goButton: UIButton!
    var footerLabel: UILabel!
    var titleLabel: UILabel!
    
    var signInView: SignInInputView!
    var signUpView: SignUpInputView!
    var passwordResetView: PasswordResetInputView!
    
    var animator: InitialAnimator!
    
    var state: InitialViewControllerState = .signIn {
        didSet {
            guard isViewLoaded, oldValue != state else { return }
            
            switch oldValue {
            case .signIn: animator.hideSignInView()
            case .signUp: animator.hideSignUpView()
            case .passwordReset: animator.hidePasswordResetView()
            }
            
            switch state {
            case .signIn:
                animator.changeFooterText(state.footerText)
                animator.showSignInView()
                
            case .signUp:
                animator.changeFooterText(state.footerText)
                animator.showSignUpView()
                
            case .passwordReset:
                animator.changeFooterText(state.footerText)
                animator.showPasswordResetView()
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        
        var theme = UITheme()
        
        view.backgroundColor = theme.color.black
        
        goButton = UIButton()
        goButton.backgroundColor = theme.color.pink
        goButton.layer.masksToBounds = true
        goButton.tintColor = UIColor.white
        goButton.setImage(#imageLiteral(resourceName: "forward_arrow"), for: .normal)
        goButton.setImage(#imageLiteral(resourceName: "forward_arrow"), for: .highlighted)
        goButton.addTarget(self, action: #selector(self.didTapGoButton), for: .touchUpInside)
        
        footerLabel = UILabel()
        footerLabel.textAlignment = .center
        
        let attributedText = NSAttributedString(
            string: "DUYOG",
            attributes: [
                NSKernAttributeName: 3,
                NSFontAttributeName: theme.font.bold(44),
                NSForegroundColorAttributeName: UIColor.white
            ]
        )
        
        titleLabel = UILabel()
        titleLabel.attributedText = attributedText
        titleLabel.textAlignment = .center
        
        signInView = SignInInputView()
        signInView.delegate = self
        signInView.emailTextField.delegate = self
        signInView.passwordTextField.delegate = self
        signInView.emailTextField.addTarget(self, action: #selector(self.didChangeValueForTextField(_:)), for: .editingChanged)
        signInView.passwordTextField.addTarget(self, action: #selector(self.didChangeValueForTextField(_:)), for: .editingChanged)
        
        signUpView = SignUpInputView()
        signUpView.displayNameTextField.delegate = self
        signUpView.emailTextField.delegate = self
        signUpView.passwordTextField.delegate = self
        signUpView.displayNameTextField.addTarget(self, action: #selector(self.didChangeValueForTextField(_:)), for: .editingChanged)
        signUpView.emailTextField.addTarget(self, action: #selector(self.didChangeValueForTextField(_:)), for: .editingChanged)
        signUpView.passwordTextField.addTarget(self, action: #selector(self.didChangeValueForTextField(_:)), for: .editingChanged)
        
        passwordResetView = PasswordResetInputView()
        passwordResetView.emailTextField.delegate = self
        passwordResetView.emailTextField.addTarget(self, action: #selector(self.didChangeValueForTextField(_:)), for: .editingChanged)
        
        view.addSubview(goButton)
        view.addSubview(footerLabel)
        view.addSubview(titleLabel)
        view.addSubview(signInView)
        view.addSubview(signUpView)
        view.addSubview(passwordResetView)
        
        animator = InitialAnimator()
        animator.footerLabel = footerLabel
        animator.signInView = signInView
        animator.signUpView = signUpView
        animator.passwordResetView = passwordResetView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(self.didTapFooterLabel))
        tap.numberOfTapsRequired = 1
        footerLabel.isUserInteractionEnabled = true
        footerLabel.addGestureRecognizer(tap)
        
        switch state {
        case .signIn:
            animator.changeFooterText(state.footerText)
            signUpView.alpha = 0
            passwordResetView.alpha = 0
        
        case .signUp:
            animator.changeFooterText(state.footerText)
            signInView.alpha = 0
            passwordResetView.alpha = 0
        
        case .passwordReset:
            animator.changeFooterText(state.footerText)
            signInView.alpha = 0
            signUpView.alpha = 0
        }
    }
    
    override func viewDidLayoutSubviews() {
        var rect = CGRect.zero
        
        rect.origin.x = 20
        rect.origin.y = 36
        rect.size.width = view.frame.width - rect.origin.x * 2
        rect.size.height = titleLabel.sizeThatFits(rect.size).height
        titleLabel.frame = rect
        
        rect.size.height = footerLabel.sizeThatFits(rect.size).height
        rect.origin.y = view.frame.height - 28 - rect.height
        footerLabel.frame = rect
        
        rect.size.width = 80
        rect.size.height = rect.width
        rect.origin.y = rect.origin.y - 16 - rect.height
        rect.origin.x = (view.frame.width - rect.width) / 2
        goButton.frame = rect
        goButton.layer.cornerRadius = rect.width / 2
    
        rect.size.width = titleLabel.frame.width
        rect.origin.x = titleLabel.frame.origin.x
        rect.size.height = 138
        rect.origin.y = (view.frame.height - rect.height) / 2
        signInView.frame = rect
        
        rect.size.height = 156
        rect.origin.y = (view.frame.height - rect.height) / 2
        signUpView.frame = rect
        
        rect.size.height = 52
        rect.origin.y = (view.frame.height - rect.height) / 2
        passwordResetView.frame = rect
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func didTapFooterLabel() {
        switch state {
        case .signIn, .passwordReset: state = .signUp
        case .signUp: state = .signIn
        }
    }
    
    func didTapGoButton() {
        
    }
    
    func didChangeValueForTextField(_ textField: UITextField) {
        guard let text = textField.text,
            let font = textField.font,
            let textColor = textField.textColor else {
                return
        }
        
        let attributedText = NSAttributedString(
            string: text,
            attributes: [
                NSKernAttributeName: 3,
                NSFontAttributeName: font,
                NSForegroundColorAttributeName: textColor
            ]
        )
        textField.attributedText = attributedText
    }
}

extension InitialViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.superview is SignInInputView {
            if textField == signInView.emailTextField {
                signInView.passwordTextField.becomeFirstResponder()
                
            } else if textField == signInView.passwordTextField {
                dismissKeyboard()
            }
        
        } else if textField.superview is SignUpInputView {
            if textField == signUpView.displayNameTextField {
                signUpView.emailTextField.becomeFirstResponder()
                
            } else if textField == signUpView.emailTextField {
                signUpView.passwordTextField.becomeFirstResponder()
                
            } else if textField == signUpView.passwordTextField {
                dismissKeyboard()
            }
        
        } else if textField.superview is PasswordResetInputView {
            if textField == passwordResetView.emailTextField {
                dismissKeyboard()
            }
        }

        return true
    }
}

extension InitialViewController: SignInInputViewDelegate {
    
    func signInInputViewWillResetPassword() {
        state = .passwordReset
    }
}
