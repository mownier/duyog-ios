//
//  MusicPlayerIndexGenerator.swift
//  Duyog
//
//  Created by Mounir Ybanez on 14/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Foundation

class MusicPlayerIndexGenerator: MusicPlayerIndexGeneratorProtocol {

    var base: Int
    var randomizer: RandomGeneratorProtocol
    var isRepeated: Bool = false
    var isShuffled: Bool = false
    
    var indexHistory: [Int] = []
    var currentIndex: Int? {
        return indexHistory.last
    }
    
    var previous: Int? {
        guard !indexHistory.isEmpty else { return nil }
        
        let _ = indexHistory.removeLast()
        return currentIndex
    }
    
    var next: Int? {
        guard base > 0 else { return nil }
        
        var newIndex: Int?
        
        if isShuffled && base > 1 {
            repeat {
                newIndex = randomizer.generate(base)
            } while(newIndex == currentIndex)
            
        } else if let index = currentIndex, index < base - 1  {
            newIndex = index + 1
            
        } else if isRepeated || currentIndex == nil {
            newIndex = 0
        }
        
        if newIndex != nil { indexHistory.append(newIndex!) }
        return newIndex
    }
    
    var hasHistory: Bool {
        return indexHistory.count > 1
    }
    
    init(base: Int, randomizer: RandomGeneratorProtocol = RandomGenerator()) {
        self.randomizer = randomizer
        self.base = base
    }
}
