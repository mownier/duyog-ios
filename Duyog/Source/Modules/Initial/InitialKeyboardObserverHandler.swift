//
//  InitialKeyboardObserverHandler.swift
//  Duyog
//
//  Created by Mounir Ybanez on 27/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class InitialKeyboardObserverHandler: KeyboardObserverDelegate {

    enum Direction {
        
        case up
        case down
    }
    
    weak var contentView: UIView!
    weak var signInView: UIView!
    weak var signUpView: UIView!
    weak var passwordResetView: UIView!
    
    func adjustView(_ targetView: UIView, _ info: KeyboardObserverInfo, _ direction: Direction) {
        var animations: (() -> Void)?
        
        let bottomMargin = (contentView.frame.height - targetView.frame.maxY)
        let diff = bottomMargin + info.frameDelta.y
        
        if info.frameDelta.height == 0 {
            switch direction {
            case .up:
                if diff < 0 {
                    animations = {
                        targetView.frame.origin.y += diff
                    }
                }
            
            case .down:
                animations = {
                    targetView.frame.origin.y = (self.contentView.frame.height - targetView.frame.height) / 2
                }
            }
            
        } else {
            animations = {
                switch direction {
                case .up: targetView.frame.origin.y -= abs(info.frameDelta.height)
                case .down: targetView.frame.origin.y += abs(info.frameDelta.height)
                }
            }

        }
        
        if animations != nil {
            UIView.animate(
                withDuration: info.animationDuration,
                delay: 0,
                options: UIViewAnimationOptions(rawValue: info.animationCurve << 16),
                animations: animations!,
                completion: { _ in })
        }
    }
    
    func keyboardWillMoveUp(_ info: KeyboardObserverInfo) {
        adjustView(signInView, info, .up)
        adjustView(signUpView, info, .up)
        adjustView(passwordResetView, info, .up)
    }
    
    func keyboardWillMoveDown(_ info: KeyboardObserverInfo) {
        adjustView(signInView, info, .down)
        adjustView(signUpView, info, .down)
        adjustView(passwordResetView, info, .down)
    }
}
