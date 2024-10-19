//
//  FriendTarget.swift
//  Score
//
//  Created by sole on 10/20/24.
//

import Foundation
import Moya

enum FriendTarget: TargetType {
    /// userID는 차단된 친구 리스트를 요청한 유저의 고유 번호를 의미합니다.
    case fetchBlockedFriends(userID: Int64)
    /// 차단했던 친구에 대해 차단을 해제합니다.
    /// agentID는 차단 해제를 요청한 유저의 고유 번호
    /// objectID는 차단에서 해제될 유저의 고유 번호를 의미합니다.
    case unblockFriend(agentID: Int64, objectID: Int64)
    /// agentID는 친구 신청을 보내는 유저의 고유 번호
    /// objectID는 친구 신청을 받는 유저의 고유 번호를 의미합니다.
    case addNewFriend(agentID: Int64, objectID: Int64)
    /// agentID는 차단을 요청한 유저의 고유 번호
    /// objectID는 차단될 유저의 고유 번호를 의미합니다.
    case blockFriend(agentID: Int64, objectID: Int64)
    /// userID는 친구 목록을 요청한 유저의 고유 번호
    /// page는 출력할 친구 리스트의 페이지 번호를 의미합니다.
    case fetchFriends(userID: Int64, page: Int32)
    /// agentID는 친구 삭제를 요청한 유저의 고유 번호
    /// objectID는 삭제될 유저의 고유 번호를 의미합니다.
    case deleteFriend(agentID: Int64, objectID: Int64)

    var baseURL: URL {
        EnvironmentValue.baseURL.appending(path: "score")
    }

    var path: String {
        var pathBaseString: String = "friends/"

        switch self {
        case .fetchBlockedFriends:
            pathBaseString += "blocked/list"
        case .unblockFriend:
            pathBaseString += "blocked/list"
        case .addNewFriend(let id1, let id2):
            pathBaseString += "new/\(id1)/\(id2)"
        case .blockFriend(let id1, let id2):
            pathBaseString += "block/\(id1)/\(id2)"
        case .fetchFriends:
            pathBaseString += "list"
        case .deleteFriend(let id1, let id2):
            pathBaseString += "delete/\(id1)/\(id2)"
        }

        return pathBaseString
    }

    var method: Moya.Method {
        switch self {
        case .fetchBlockedFriends: .get
        case .unblockFriend: .put
        case .addNewFriend: .post
        case .blockFriend: .post
        case .fetchFriends: .get
        case .deleteFriend: .delete
        }
    }

    var task: Moya.Task {
        switch self {
        case .fetchBlockedFriends(let userID):
            return .requestParameters(
                parameters: [
                    "id" : userID
                ],
                encoding: URLEncoding.queryString
            )

        case .unblockFriend(let agentID, let objectID):
            return .requestParameters(
                parameters: [
                    "id1" : agentID,
                    "id2" : objectID
                ],
                encoding: URLEncoding.queryString
            )

        case .addNewFriend(let agentID, let objectID):
            return .requestParameters(
                parameters: [
                    "id1" : agentID,
                    "id2" : objectID
                ],
                encoding: URLEncoding.queryString
            )

        case .blockFriend(let agentID, let objectID):
            return .requestParameters(
                parameters: [
                    "id1" : agentID,
                    "id2" : objectID
                ],
                encoding: URLEncoding.queryString
            )

        case .fetchFriends(let userID, let page):
            return .requestParameters(
                parameters: [
                    "id" : userID,
                    "page" : page
                ],
                encoding: URLEncoding.queryString
            )

        case .deleteFriend(let agentID, let objectID):
            return .requestParameters(
                parameters: [
                    "id1" : agentID,
                    "id2" : objectID
                ],
                encoding: URLEncoding.queryString
            )
        }
    }

    var headers: [String : String]? {
        EnvironmentValue.defaultHeader
    }
}
