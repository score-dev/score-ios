//
//  APIProtocol.swift
//  Score
//
//  Created by sole on 5/21/24.
//

import Foundation

protocol APIProtocol {
    associatedtype T
    
    var serverURL: String { get }
    var endpoint: String { get set }
    func get() async throws -> [T]
    func post() async throws
    func delete() async throws
    func patch() async throws
}
