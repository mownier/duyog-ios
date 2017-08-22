//
//  JSONSerializer.swift
//  Duyog
//
//  Created by Mounir Ybanez on 22/08/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Foundation

enum JSONCoderResult<T> {
    
    case ok(T)
    case err(Error)
}

struct JSONCoderError: Error {
    
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}

protocol JSONEncoder {
    
    func encode(_ object: Any) -> JSONCoderResult<Data>
}

protocol JSONDecoder {
    
    func decode(_ data: Data) -> JSONCoderResult<Any>
}

protocol JSONSerializer {
    
    var encoder: JSONEncoder { get }
    var decoder: JSONDecoder { get }
}

struct JSONEncodeAgent: JSONEncoder {
    
    private var serialization: JSONSerialization.Type
    
    init(_ serialization: JSONSerialization.Type = JSONSerialization.self) {
        self.serialization = serialization
    }
    
    func encode(_ object: Any) -> JSONCoderResult<Data> {
        guard let data = try? serialization.data(withJSONObject: object, options: []) else {
            return .err(JSONCoderError("can not encode object to JSON data"))
        }
        
        return .ok(data)
    }
}

struct JSONDecodeAgent: JSONDecoder {
    
    private var serialization: JSONSerialization.Type
    
    init(_ serialization: JSONSerialization.Type = JSONSerialization.self) {
        self.serialization = serialization
    }
    
    func decode(_ data: Data) -> JSONCoderResult<Any> {
        guard let info = try? serialization.jsonObject(with: data, options: []) else {
            return .err(JSONCoderError("can not decode data to JSON object"))
        }
        
        return .ok(info)
    }
}

struct JSONParser: JSONSerializer {
    
    var encoder: JSONEncoder
    var decoder: JSONDecoder
    
    init(encoder: JSONEncoder = JSONEncodeAgent(), decoder: JSONDecoder = JSONDecodeAgent()) {
        self.encoder = encoder
        self.decoder = decoder
    }
}
