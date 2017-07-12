//
//  MusicPlayerViewControllerGenerator.swift
//  Duyog
//
//  Created by Mounir Ybanez on 11/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

class MusicPlayerViewControllerGenerator: MusicPlayerViewControllerGeneratorProtocol {

    func generate() -> MusicPlayerPresenterOutputProtocol & MusicPlayerViewControllerProtocol {
        return MusicPlayerViewController()
    }
}
