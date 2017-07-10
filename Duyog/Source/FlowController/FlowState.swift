//
//  FlowState.swift
//  Duyog
//
//  Created by Mounir Ybanez on 10/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

enum FlowState {
    
    case present(UIViewController, Bool, UINavigationController?)
    case push(UIViewController, Bool)
    case root(UINavigationController?)
    
    struct Info {
        
        var module: FlowModuleProtocol
        var state: FlowState
        var viewController: UIViewController
        
        init(_ module: FlowModuleProtocol, _ state: FlowState, _ viewController: UIViewController) {
            self.module = module
            self.state = state
            self.viewController = viewController
        }
    }
}
