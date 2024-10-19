//
//  SchoolAPITarget.swift
//  Score
//
//  Created by sole on 10/19/24.
//

import Foundation
import Moya

enum SchoolAPITarget: TargetType {
    case fetch(page: Int, perPage: Int)

    var baseURL: URL {
        Environment.schoolAPIURL
    }

    var path: String {
        ""
    }

    var method: Moya.Method {
        .get
    }

    var task: Moya.Task {
        guard let apiKey = Bundle.main.infoDictionary?["SCHOOL_API_KEY"] as? String else {
            fatalError("\(#function)invalid URL for API KEY")
        }
        switch self {
        case .fetch(let page, let perPage):
            return .requestParameters(
                parameters: [
                    "KEY" : apiKey,
                    "Type" : "json",
                    "pIndex": page,
                    "pSize": perPage
                ],
                encoding: URLEncoding.queryString
            )
        }
    }

    var headers: [String : String]? {
        nil
    }
}
