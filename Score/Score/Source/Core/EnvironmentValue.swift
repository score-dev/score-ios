//
//  Environment.swift
//  Score
//
//  Created by sole on 10/20/24.
//

import Foundation

enum EnvironmentValue {
    static let baseURL: URL = {
        guard let baseURLString = Bundle.main.infoDictionary?["BASE_URL"] as? String,
              let url = URL(string: baseURLString.replacingOccurrences(of: #"\"#, with: "")) else {
            fatalError("\(#function)invalid URL for baseURL")
        }
        return url
    }()

    static let naverClientID: String = {
        guard let naverClientID = Bundle.main.infoDictionary?["NAVER_CLIENT_ID"] as? String else {
            fatalError("\(#function)invalid")
        }
        return naverClientID
    }()

    static let naverClientKey: String = {
        guard let naverClientKey = Bundle.main.infoDictionary?["NAVER_SECRET_KEY"] as? String else {
            fatalError("\(#function)invalid")
        }
        return naverClientKey
    }()

    static let kakaoAppID: String = {
        guard let kakaoAppID = Bundle.main.infoDictionary?["KAKAO_APP_ID"] as? String else {
            fatalError("\(#function)invalid")
        }
        return kakaoAppID
    }()

    static let schoolAPIURL: URL = {
        guard let baseURLString = Bundle.main.infoDictionary?["SCHOOL_BASE_URL"] as? String,
              let url = URL(string: baseURLString.replacingOccurrences(of: #"\"#, with: "")) else {
            fatalError("\(#function)invalid")
        }
        return url
    }()

    static let schoolAPIKey: String = {
        guard let apiKey = Bundle.main.infoDictionary?["SCHOOL_API_KEY"] as? String else {
            fatalError("\(#function)invalid")
        }
        return apiKey
    }()

    static let defaultHeader: [String: String] = [
        "Accept" : "application/json",
        "Content-Type" : "application/json"
    ]
}
