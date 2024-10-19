//
//  Environment.swift
//  Score
//
//  Created by sole on 10/20/24.
//

import Foundation

enum Environment {
    static let baseURL: URL = {
        guard let baseURLString = Bundle.main.infoDictionary?["BASE_URL"] as? String,
              let url = URL(string: baseURLString.replacingOccurrences(of: #"\"#, with: "")) else {
            fatalError("\(#function)invalid URL for baseURL")
        }
        return url
    }()

    static let schoolAPIURL: URL = {
        guard let baseURLString = Bundle.main.infoDictionary?["SCHOOL_BASE_URL"] as? String,
              let url = URL(string: baseURLString.replacingOccurrences(of: #"\"#, with: "")) else {
            fatalError("\(#function)invalid URL for schoolAPIURL")
        }
        return url
    }()

    static let defaultHeader: [String: String] = [
        "Accept" : "application/json",
        "Content-Type" : "application/json"
    ]
}
