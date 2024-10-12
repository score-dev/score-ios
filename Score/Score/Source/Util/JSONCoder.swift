//
//  JSONCoder.swift
//  Score
//
//  Created by sole on 10/10/24.
//

import Foundation

enum JSONCoder {
    static let encoder: JSONEncoder = {
        let encoder: JSONEncoder = .init()
        return encoder
    }()

    static let decoder: JSONDecoder = {
        let decoder: JSONDecoder = .init()
        return decoder
    }()
}
