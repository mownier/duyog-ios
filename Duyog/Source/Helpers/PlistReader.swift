//
//  PlistReader.swift
//  Duyog
//
//  Created by Mounir Ybanez on 22/08/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Foundation

struct PlistReaderError: Error {
    
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}

enum PlistReaderResult {

    case ok(Any)
    case err(Error)
}

protocol PlistReader {
    
    func read(_ name: String) -> PlistReaderResult
}

class PlistResourceReader: PlistReader {
    
    func read(_ name: String) -> PlistReaderResult {
        guard let path = Bundle.main.path(forResource: name, ofType: "plist") else {
            return .err(PlistReaderError("No file named '\(name).plist' is found."))
        }
        
        guard let xml = FileManager.default.contents(atPath: path) else {
            return .err(PlistReaderError( "'\(name).plist' has no contents."))
        }
        
        var format = PropertyListSerialization.PropertyListFormat.xml
        
        do {
            let data = try PropertyListSerialization.propertyList(from: xml, options: [], format: &format)
            return .ok(data)
        } catch {
            return .err(PlistReaderError("Error reading plist: \(error), format: \(format)"))
        }
    }
}

