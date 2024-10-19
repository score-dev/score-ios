//
//  FeedReportTarget.swift
//  Score
//
//  Created by sole on 10/20/24.
//

import Foundation
import Moya

enum FeedReportTarget: TargetType {
    /// reportFeedDTOData는 ReportFeedDTO를 Data로 정의합니다.
    case reportFeed(reportFeedDTOData: Data)

    var baseURL: URL {
        EnvironmentValue.baseURL.appending(path: "score")
    }

    var path: String {
        "exercise/report"
    }

    var method: Moya.Method {
        .post
    }

    var task: Moya.Task {
        switch self {
        case .reportFeed(let reportFeedDTOData):
            return .requestData(reportFeedDTOData)
        }
    }

    var headers: [String : String]? {
        EnvironmentValue.defaultHeader
    }
}
