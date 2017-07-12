//
//  InitialViewControllerGenerator.swift
//  Duyog
//
//  Created by Mounir Ybanez on 12/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class InitialViewControllerGenerator: InitialViewControllerGeneratorProtocol {

    func generate() -> InitialViewControllerProtocol & InitialPresenterOutputProtocol {
        return InitialViewController()
    }
}


