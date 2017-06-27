//
//  KeyboardObserverProtocol.swift
//  Duyog
//
//  Created by Mounir Ybanez on 27/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol KeyboardObserverProtocol: class {
    
    func add()
    func remove()
}

protocol KeyboardObserverDelegate: class {
    
    func keyboardWillMoveUp(_ info: KeyboardObserverInfo)
    func keyboardWillMoveDown(_ info: KeyboardObserverInfo)
}

class KeyboardObserver: KeyboardObserverProtocol {
    
    var keyboardObserver: Any?
    
    weak var delegate: KeyboardObserverDelegate?
    
    var center: NotificationCenter
    var name: Notification.Name
    
    init(center: NotificationCenter = .default, name: Notification.Name = .UIKeyboardWillChangeFrame) {
        self.center = center
        self.name = name
    }
    
    func add() {
        keyboardObserver = center.addObserver(
            forName: name,
            object: nil,
            queue: nil) { [unowned self] notif in
                self.handleKeyboardNotification(notif)
        }
    }
    
    func remove() {
        guard keyboardObserver != nil else { return }
        
        NotificationCenter.default.removeObserver(keyboardObserver!)
    }
    
    func handleKeyboardNotification(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let frameEnd = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let frameBegin = userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue else {
            return
        }
        
        let rectEnd = frameEnd.cgRectValue
        let rectBegin = frameBegin.cgRectValue
        
        var info = KeyboardObserverInfo()
        info.frameDelta.height = rectEnd.size.height - rectBegin.size.height
        info.frameDelta.y = rectEnd.origin.y - rectBegin.origin.y
        info.animationCurve = (userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt) ?? 0
        info.animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double) ?? 0
        
        if rectEnd.origin.y < rectBegin.origin.y {
            delegate?.keyboardWillMoveUp(info)
            
        } else if rectEnd.origin.y > rectBegin.origin.y {
            delegate?.keyboardWillMoveDown(info)
        }
    }
}

struct KeyboardFrameDelta {
    
    var height: CGFloat
    var y: CGFloat
    
    init() {
        height = 0
        y = 0
    }
}

struct KeyboardObserverInfo {
    
    var frameDelta: KeyboardFrameDelta
    var animationCurve: UInt
    var animationDuration: Double
    
    init() {
        frameDelta = KeyboardFrameDelta()
        animationCurve = 0
        animationDuration = 0
    }
}
