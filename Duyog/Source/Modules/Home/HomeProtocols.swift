//
//  HomeProtocols.swift
//  Duyog
//
//  Created by Mounir Ybanez on 12/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol HomeInteractorInputProtocol: class {
    
    func fetchData()
}

protocol HomeInteractorOutputProtocol: class {
    
    func didFetchData()
}

protocol HomePresenterOutputProtocol: class {
    
    func displayData()
}

protocol HomeModuleOutputProtocol: class {
    
}

protocol HomeAssemblyProtocol: class {
    
    var generator: HomeViewControllerGeneratorProtocol! { set get }
    
    func assemble(_ moduleOutput: HomeModuleOutputProtocol?) -> UIViewController
}

protocol HomeViewControllerProtocol: class {
    
    var interactor: HomeInteractorInputProtocol! { set get }
    var moduleOutput: HomeModuleOutputProtocol? { set get }
}

protocol HomeViewControllerGeneratorProtocol: class {
    
    func generate() -> HomeViewControllerProtocol & HomePresenterOutputProtocol
}
