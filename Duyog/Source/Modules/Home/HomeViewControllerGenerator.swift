//
//  HomeViewControllerGenerator.swift
//  Duyog
//
//  Created by Mounir Ybanez on 12/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

class HomeViewControllerGenerator: HomeViewControllerGeneratorProtocol {

    func generate() -> HomePresenterOutputProtocol & HomeViewControllerProtocol {
        return HomeViewController()
    }
}
