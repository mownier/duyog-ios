//
//  FlowController.swift
//  Duyog
//
//  Created by Mounir Ybanez on 10/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

enum FlowModule {
    
    case songList
    case musicPlayer
}

enum FlowState {
    
    case present(UIViewController, Bool)
    case push(UIViewController, Bool)
    case root
    
    struct Info {
        
        var module: FlowModule
        var state: FlowState
        var viewController: UIViewController
        
        init(module: FlowModule, state: FlowState, viewController: UIViewController) {
            self.module = module
            self.state = state
            self.viewController = viewController
        }
    }
}

protocol FlowControllable: class {
    
    var flowController: FlowControllerProtocol! { set get }
}

protocol FlowControllerProtocol {
    
    func exit(_ animated: Bool)
}

class FlowController: FlowControllerProtocol {
    
    var window: UIWindow
    var stateInfo: [FlowState.Info]
    
    init(window: UIWindow) {
        self.window = window
        self.stateInfo = []
    }
    
    func processState(_ state: FlowState, child: UIViewController) {
        if let controllable = child as? FlowControllable {
            controllable.flowController = self
        }
        
        switch state {
        case .present(let parent, let animated):
            parent.present(child, animated: animated, completion: nil)
            
        case .push(let parent, let animated):
            parent.navigationController?.pushViewController(child, animated: animated)
            
        case .root:
            window.rootViewController = child
        }
    }
    
    func exit(_ animated: Bool) {
        guard stateInfo.count > 0 else { return }
        
        let info = stateInfo.removeLast()
        
        switch info.state {
        case .present:
            info.viewController.dismiss(animated: animated, completion: nil)
            
        case .push:
            let _ = info.viewController.navigationController?.popViewController(animated: animated)
            
        case .root:
            stateInfo.removeAll()
            window.rootViewController = nil
        }
    }
}
