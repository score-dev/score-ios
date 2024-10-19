//
//  ExerciseTarget.swift
//  Score
//
//  Created by sole on 10/20/24.
//

import Foundation
import Moya

enum ExerciseTarget: TargetType {
    case saveFeed(walkingDTOData: Data)
    case fetchDetailFeed(feedID: Int64)
    /// agentID는 피드 목록을 요청한 유저의 고유 번호
    /// objectID는 조회하고자 하는 유저의 고유 번호
    /// page는 출력할 피드 리스트의 페이지 번호를 의미합니다.
    case fetchFeeds(agentID: Int64, objectID: Int64, page: Int32)
    /// agentID는 피드를 업로드하는 유저의 고유 ID
    /// nickName은 유저가 필드에 입력한 내 친구의 닉네임을 의미합니다.
    case searchFriends(agentID: Int64, nickName: String)
    case deleteFeed(feedID: Int64)

    var baseURL: URL {
        Environment.baseURL.appending(path: "score")
    }

    var path: String {
        var pathBaseString: String = "exercise/"
        switch self {
        case .saveFeed: 
            pathBaseString += "walking/save"
        case .fetchDetailFeed:
            pathBaseString += "read"
        case .fetchFeeds:
            pathBaseString += "list"
        case .searchFriends:
            pathBaseString += "friends"
        case .deleteFeed:
            pathBaseString += "delete"
        }
        return pathBaseString
    }

    var method: Moya.Method {
        switch self {
        case .saveFeed: .post
        case .fetchDetailFeed: .get
        case .fetchFeeds: .get
        case .searchFriends: .get
        case .deleteFeed: .delete
        }
    }

    var task: Moya.Task {
        switch self {
        case .saveFeed(let walkingDTOData):
            return .requestData(walkingDTOData)

        case .fetchDetailFeed(let feedID):
            return .requestParameters(
                parameters: [
                    "feedId": feedID
                ],
                encoding: URLEncoding.queryString
            )

        case .fetchFeeds(let agentID, let objectID, let page):
            return .requestParameters(
                parameters: [
                    "id1" : agentID,
                    "id2" : objectID,
                    "page" : page
                ],
                encoding: URLEncoding.queryString
            )

        case .searchFriends(let agentID, let nickName):
            return .requestParameters(
                parameters: [
                    "id" : agentID,
                    "nickname" : nickName
                ],
                encoding: URLEncoding.queryString
            )

        case .deleteFeed(let feedID):
            return .requestParameters(
                parameters: [
                    "id" : feedID
                ],
                encoding: URLEncoding.queryString
            )
        }
    }

    var headers: [String : String]? {
        Environment.defaultHeader
    }
}
