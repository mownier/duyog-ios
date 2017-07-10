//
//  FlowController.swift
//  Duyog
//
//  Created by Mounir Ybanez on 10/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol FlowControllable: class {
    
    var flowController: FlowControllerProtocol! { set get }
}

protocol FlowControllerProtocol {
    
    func enter(_ state: FlowState, module: FlowModule, viewController: UIViewController)
    func exit(_ animated: Bool)
}

class FlowController: FlowControllerProtocol {
    
    var window: UIWindow
    var stateInfo: [FlowState.Info]
    
    init(window: UIWindow) {
        self.window = window
        self.stateInfo = []
    }
    
    func enter(_ state: FlowState, module: FlowModule, viewController: UIViewController) {
        if let controllable = viewController as? FlowControllable {
            controllable.flowController = self
        }
        
        switch state {
        case .present(let parent, let animated, let nav):
            let presented: UIViewController
            if nav != nil {
                nav!.pushViewController(viewController, animated: false)
                presented = nav!
                
            } else {
                presented = viewController
            }
            parent.present(presented, animated: animated, completion: nil)
            
        case .push(let parent, let animated):
            parent.navigationController?.pushViewController(viewController, animated: animated)
            
        case .root(let nav):
            let root: UIViewController
            if nav != nil {
                nav!.pushViewController(viewController, animated: false)
                root = nav!
            
            } else {
                root = viewController
            }
            window.rootViewController = root
        }
        
        stateInfo.append(FlowState.Info(module, state, viewController))
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
