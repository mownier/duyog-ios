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
        info.frameHeight = rectEnd.height
        info.deltaHeight = rectEnd.height - rectBegin.height
        info.animationCurve = (userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt) ?? 0
        info.animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double) ?? 0
        
        if rectEnd.origin.y < rectBegin.origin.y {
            delegate?.keyboardWillMoveUp(info)
            
        } else if rectEnd.origin.y > rectBegin.origin.y {
            delegate?.keyboardWillMoveDown(info)
        }
    }
}

struct KeyboardObserverInfo {
    
    var deltaHeight: CGFloat
    var frameHeight: CGFloat
    var animationCurve: UInt
    var animationDuration: Double
    
    init() {
        deltaHeight = 0
        frameHeight = 0
        animationCurve = 0
        animationDuration = 0
    }
}

class KeyboardAdjustment {
    
    enum Direction {
        
        case up
        case down
    }
    
    weak var contentView: UIView!
    weak var targetView: UIView!
    
    var originalFrame: CGRect = .zero
    
    init(contentView: UIView, targetView: UIView) {
        self.contentView = contentView
        self.targetView = targetView
    }
    
    func adjust(_ info: KeyboardObserverInfo, direction: Direction) {
        var animations: (() -> Void)?
        
        let bottomMargin = (contentView.frame.height - targetView.frame.maxY)
        
        if info.deltaHeight == 0 {
            switch direction {
            case .up:
                originalFrame = targetView.frame
                if info.frameHeight > bottomMargin {
                    animations = {
                        self.targetView.frame.origin.y -= (info.frameHeight - bottomMargin)
                    }
                }
                
            case .down:
                animations = {
                    self.targetView.frame = self.originalFrame
                }
            }
            
        } else {
            if info.frameHeight > bottomMargin {
                animations = {
                    self.targetView.frame.origin.y -= info.deltaHeight
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
}

class KeyboardAdjustmentHandler: KeyboardObserverDelegate {
    
    var adjustments: [KeyboardAdjustment]
    
    init(adjustments: [KeyboardAdjustment]) {
        self.adjustments = adjustments
    }
    
    func keyboardWillMoveDown(_ info: KeyboardObserverInfo) {
        for adjustment in adjustments { adjustment.adjust(info, direction: .down) }
    }
    
    func keyboardWillMoveUp(_ info: KeyboardObserverInfo) {
        for adjustment in adjustments { adjustment.adjust(info, direction: .up) }
    }
}

class KeyboardManager {
    
    var handler: KeyboardObserverDelegate
    var observer: KeyboardObserverProtocol
    
    class func create(adjustments: [KeyboardAdjustment]) -> KeyboardManager {
        let handler = KeyboardAdjustmentHandler(adjustments: adjustments)
        let observer = KeyboardObserver()
        observer.delegate = handler
        let manager = KeyboardManager(observer: observer, handler: handler)
        return manager
    }
    
    init(observer: KeyboardObserverProtocol, handler: KeyboardObserverDelegate) {
        self.handler = handler
        self.observer = observer
    }
}
