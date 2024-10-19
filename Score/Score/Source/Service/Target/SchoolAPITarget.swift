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
        EnvironmentValue.schoolAPIURL
    }

    var path: String {
        ""
    }

    var method: Moya.Method {
        .get
    }

    var task: Moya.Task {
        switch self {
        case .fetch(let page, let perPage):
            return .requestParameters(
                parameters: [
                    "KEY" : EnvironmentValue.schoolAPIKey,
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
