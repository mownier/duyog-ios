//
//  SignUpViewController.swift
//  Duyog
//
//  Created by Mounir Ybanez on 26/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    var textFieldContainerView: GradientView!
    var displayNameTextField: UITextField!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var stripView: UIView!
    var stripView2: UIView!
    var goButton: UIButton!
    var footerLabel: UILabel!
    var titleLabel: UILabel!
    
    override func loadView() {
        super.loadView()
        
        var theme = UITheme()
        view.backgroundColor = theme.color.black
        
        textFieldContainerView = GradientView()
        textFieldContainerView.layer.cornerRadius = 8
        textFieldContainerView.layer.masksToBounds = true
        textFieldContainerView.gradientLayer.colors = [theme.color.pink.cgColor, theme.color.violet.cgColor]
        textFieldContainerView.gradientLayer.gradient = GradientPoint.rightLeft.draw()
        
        var attributedText = NSAttributedString(
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
        emailTextField.addTarget(self, action: #selector(self.didChangeValueForTextField(_:)), for: .editingChanged)
        emailTextField.returnKeyType = .next
        emailTextField.delegate = self
        
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
        passwordTextField.addTarget(self, action: #selector(self.didChangeValueForTextField(_:)), for: .editingChanged)
        passwordTextField.returnKeyType = .done
        passwordTextField.delegate = self
        
        attributedText = NSAttributedString(
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
        displayNameTextField.addTarget(self, action: #selector(self.didChangeValueForTextField(_:)), for: .editingChanged)
        displayNameTextField.returnKeyType = .next
        displayNameTextField.delegate = self
        
        stripView = UIView()
        stripView.backgroundColor = theme.color.gray.withAlphaComponent(0.4)
        
        stripView2 = UIView()
        stripView2.backgroundColor = theme.color.gray.withAlphaComponent(0.4)
        
        goButton = UIButton()
        goButton.backgroundColor = theme.color.pink
        goButton.layer.masksToBounds = true
        goButton.tintColor = UIColor.white
        goButton.setImage(#imageLiteral(resourceName: "forward_arrow"), for: .normal)
        goButton.setImage(#imageLiteral(resourceName: "forward_arrow"), for: .highlighted)
        goButton.addTarget(self, action: #selector(self.didTapGoButton), for: .touchUpInside)
        
        attributedText = NSAttributedString(
            string: "ALREADY HAVE AN ACCOUNT?",
            attributes: [
                NSKernAttributeName: 3,
                NSFontAttributeName: theme.font.regular(11),
                NSForegroundColorAttributeName: theme.color.gray
            ]
        )
        
        footerLabel = UILabel()
        footerLabel.attributedText = attributedText
        footerLabel.textAlignment = .center
        
        attributedText = NSAttributedString(
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
        
        textFieldContainerView.addSubview(stripView)
        textFieldContainerView.addSubview(stripView2)
        textFieldContainerView.addSubview(displayNameTextField)
        textFieldContainerView.addSubview(emailTextField)
        textFieldContainerView.addSubview(passwordTextField)
        view.addSubview(textFieldContainerView)
        view.addSubview(goButton)
        view.addSubview(footerLabel)
        view.addSubview(titleLabel)
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
    }
    
    override func viewDidLayoutSubviews() {
        var rect = CGRect.zero
        
        rect.origin.x = 20
        rect.size.width = view.frame.width - rect.origin.x * 2
        rect.size.height = 156
        rect.origin.y = (view.frame.height - rect.height) / 2
        textFieldContainerView.frame = rect
        
        rect.size.height = 1
        rect.origin.x = 0
        rect.origin.y = 52
        stripView.frame = rect
        
        rect.origin.y = 105
        stripView2.frame = rect
        
        rect.origin.x = 4
        rect.origin.y = 0
        rect.size.width = textFieldContainerView.frame.width - rect.origin.x * 2
        rect.size.height = 52
        displayNameTextField.frame = rect
        
        rect.origin.y = rect.maxY
        emailTextField.frame = rect
        
        rect.origin.y = rect.maxY
        passwordTextField.frame = rect
        
        rect.size.width = textFieldContainerView.frame.width
        rect.size.height = footerLabel.sizeThatFits(rect.size).height
        rect.origin.x = textFieldContainerView.frame.origin.x
        rect.origin.y = view.frame.height - 28 - rect.height
        footerLabel.frame = rect
        
        rect.size.width = 80
        rect.size.height = rect.width
        rect.origin.y = rect.origin.y - 16 - rect.height
        rect.origin.x = (view.frame.width - rect.width) / 2
        goButton.frame = rect
        goButton.layer.cornerRadius = rect.width / 2
        
        rect.size.width = textFieldContainerView.frame.width
        rect.origin.x = textFieldContainerView.frame.origin.x
        rect.origin.y = 36
        rect.size.height = titleLabel.sizeThatFits(rect.size).height
        titleLabel.frame = rect
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func didTapFooterLabel() {
        showSignIn()
    }
    
    func didTapGoButton() {
        
    }
    
    func showSignIn() {
        guard let index = navigationController?.viewControllers.index(where: { vc -> Bool in
            return vc is SignInViewController
        }), let vc = navigationController?.viewControllers[index] else {
            let signIn = SignInViewController()
            navigationController?.pushViewController(signIn, animated: true)
            return
        }

        let _ = navigationController?.popToViewController(vc, animated: true)
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == displayNameTextField {
            emailTextField.becomeFirstResponder()
        
        } else if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
            
        } else if textField == passwordTextField {
            dismissKeyboard()
        }
        
        return true
    }
}
