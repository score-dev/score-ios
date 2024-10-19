//
//  EmotionTarget.swift
//  Score
//
//  Created by sole on 10/20/24.
//

import Foundation
import Moya

enum EmotionTarget: TargetType {
    /// agentID는 감정 표현을 누른 유저의 고유 번호
    /// emotionType은 좋아요(like), 최고예요(best), 응원해요(support), 축하해요(congrat), 일등이에요(first) 중 어떤 감정 표현인지 Available values : LIKE, BEST, SUPPORT, CONGRAT, FIRST
    case updateEmotion(agentID: Int64, feedID: Int64, emotionType: String)
    /// 해당 피드에 추가되어 있는 특정 타입의 감정 표현의 리스트를 불러옵니다.
    /// emotionType은 좋아요(like), 최고예요(best), 응원해요(support), 축하해요(congrat), 일등이에요(first) 중 어떤 감정 표현인지 Available values : LIKE, BEST, SUPPORT, CONGRAT, FIRST
    case fetchEmotions(feedID: Int64, emotionType: String)
    case fetchFeedEmotions(feedID: Int64)

    var baseURL: URL {
        Environment.baseURL.appending(path: "score")
    }

    var path: String {
        var pathBaseString: String = "exercise/emotion/"

        switch self {
        case .updateEmotion:
            break
        case .fetchEmotions:
            pathBaseString += "list/types"
        case .fetchFeedEmotions:
            pathBaseString += "list/all"
        }

        return pathBaseString
    }

    var method: Moya.Method {
        switch self {
        case .updateEmotion: .post
        case .fetchEmotions: .get
        case .fetchFeedEmotions: .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .updateEmotion(let agentID, let feedID, let emotionType):
            return .requestParameters(
                parameters: [
                    "agentId" : agentID,
                    "feedId" : feedID,
                    "type" : emotionType
                ],
                encoding: URLEncoding.queryString
            )

        case .fetchEmotions(let feedID, let emotionType):
            return .requestParameters(
                parameters: [
                    "feedId" : feedID,
                    "emotionType" : emotionType
                ],
                encoding: URLEncoding.queryString
            )

        case .fetchFeedEmotions(let feedID):
            return .requestParameters(
                parameters: [
                    "feedId" : feedID
                ],
                encoding: URLEncoding.queryString
            )
        }
    }

    var headers: [String : String]? {
        Environment.defaultHeader
    }
}
