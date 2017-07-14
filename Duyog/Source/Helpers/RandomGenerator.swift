//
//  RandomGenerator.swift
//  Duyog
//
//  Created by Mounir Ybanez on 14/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Foundation

protocol RandomGeneratorProtocol: class {
    
    func generate(_ base: Int) -> Int
}


class RandomGenerator: RandomGeneratorProtocol {

    func generate(_ base: Int) -> Int {
        return Int(arc4random()) % base
    }
}
