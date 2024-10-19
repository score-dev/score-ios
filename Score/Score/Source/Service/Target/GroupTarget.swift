//
//  GroupTarget.swift
//  Score
//
//  Created by sole on 10/20/24.
//

import Foundation
import Moya

enum GroupTarget: TargetType {
    // FIXME: CreateGroupDTO -> UpdateGroupDTO로 변경 필요
    /// 그룹 정보 수정
    /// adminID는 그룹 정보를 수정하려는 유저의 ID를 의미합니다.
    /// groupDTOData는 UpdateGroupDTO를 Data로 받습니다.
    case updateGroup(groupID: Int64, adminID: Int64, groupDTOData: Data)
    /// 그룹 가입
    /// userID는 가입하려는 유저의 ID입니다.
    case joinGroup(groupID: Int64, userID: Int64)
    /// 그룹 떠나기
    /// userID는 그룹을 떠나고자 하는 유저의 ID입니다.
    case leaveGroup(groupID: Int64, userID: Int64)
    /// 바통 찌르기
    /// senderID는 바통을 찌른 유저의 ID
    /// receiverID는 바통을 찔린 유저의 ID를 의미합니다.
    case batonMate(senderID: Int64, receiverID: Int64)
    /// 그룹 생성
    /// adminID는 새로운 그룹을 만드는 유저의 ID를 의미합니다.
    /// groupDTOData는 CreateGroupDTO를 Data로 받습니다.
    case createGroup(adminID: Int64, groupDTOData: Data)
    /// 그룹 랭킹 조회
    /// localDate는 랭킹을 조회하고자 하는 주차의 월요일에 해당하는 날짜를 의미합니다. localDate를 nil로 설정하는 경우 가장 최근 주차의 랭킹으로 응답합니다.
    case fetchRanking(groupID: Int64, localDate: String?)
    /// 오늘 운동을 쉰 메이트의 목록
    /// userID는 목록 조회를 요청한 유저의 ID를 의미합니다.
    case fetchTodayNonExercisedMates(groupID: Int64, userID: Int64)
    /// 그룹 내 메이트 전체 조회
    case fetchGroupMatesAll(groupID: Int64)
    /// 그룹 정보 조회
    case fetchGroupInfo(userID: Int64, groupID: Int64)
    /// 그룹 피드 목록 조회
    /// 그룹원이 업로드한 전체 피드 목록을 페이지 단위로 제공합니다.
    case fetchGroupFeeds(userID: Int64, groupID: Int64, page: Int32)
    /// 유저의 그룹 목록 조회
    case fetchUserGroupsAll(userID: Int64)
    /// 그룹 멤버 강퇴
    /// userID는 강퇴하고자 하는 멤버의 ID를 의미합니다. -> 맞는지 확인
    case removeMate(groupID: Int64, userID: Int64)

    var baseURL: URL {
        EnvironmentValue.baseURL.appending(path: "api")
    }

    var path: String {
        var pathBaseString: String = "groups/"
        
        switch self {
        case .updateGroup(let groupID, _, _):
            pathBaseString += "\(groupID)/update"

        case .joinGroup:
            pathBaseString += "join"

        case .leaveGroup(let groupID, _):
            pathBaseString += "\(groupID)/leave"

        case .batonMate:
            pathBaseString += "mates/baton"

        case .createGroup:
            pathBaseString += "create"

        case .fetchRanking:
            pathBaseString += "ranking"

        case .fetchTodayNonExercisedMates:
            pathBaseString += "mates/nonExercised"

        case .fetchGroupMatesAll:
            pathBaseString += "mates/list"

        case .fetchGroupInfo:
            pathBaseString += "info"

        case .fetchGroupFeeds:
            pathBaseString += "exercise/list"

        case .fetchUserGroupsAll:
            pathBaseString += "all"

        case .removeMate(let groupID, _):
            pathBaseString += "\(groupID)/removeMember"
        }

        return pathBaseString
    }
    
    var method: Moya.Method {
        switch self {
        case .updateGroup: .put
        case .joinGroup: .put
        case .leaveGroup: .post
        case .batonMate: .post
        case .createGroup: .post
        case .fetchRanking: .get
        case .fetchTodayNonExercisedMates: .get
        case .fetchGroupMatesAll: .get
        case .fetchGroupInfo: .get
        case .fetchGroupFeeds: .get
        case .fetchUserGroupsAll: .get
        case .removeMate: .delete
        }
    }

    var task: Moya.Task {
        switch self {
        case .updateGroup(let groupID, let adminID, let groupDTOData):
            return .requestCompositeData(
                bodyData: groupDTOData,
                urlParameters: [
                    "adminId" : adminID
                ]
            )

        case .joinGroup(let groupID, let userID):
            return .requestParameters(
                parameters: [
                    "groupId" : groupID,
                    "userId" : userID
                ],
                encoding: URLEncoding.queryString
            )

        case .leaveGroup(let groupID, let userID):
            return .requestParameters(
                parameters: [
                    "userId" : userID
                ],
                encoding: URLEncoding.queryString
            )

        case .batonMate(let senderID, let receiverID):
            return .requestParameters(
                parameters: [
                    "senderId" : senderID,
                    "receiverId" : receiverID
                ],
                encoding: URLEncoding.queryString
            )

        case .createGroup(let adminID, let groupDTOData):
            return .requestCompositeData(
                bodyData: groupDTOData,
                urlParameters: [
                    "adminId" : adminID
                ]
            )

        // FIXME: localDate가 nil일 때도 최신 주차로 fetch 되는지 확인 필요
        case .fetchRanking(let groupID, let localDate):
            return .requestParameters(
                parameters: [
                    "groupId" : groupID,
                    "localDate" : localDate
                ],
                encoding: URLEncoding.queryString
            )

        case .fetchTodayNonExercisedMates(let groupID, let userID):
            return .requestParameters(
                parameters: [
                    "groupId" : groupID,
                    "userId" : userID
                ],
                encoding: URLEncoding.queryString
            )

        case .fetchGroupMatesAll(let groupID):
            return .requestParameters(
                parameters: [
                    "groupId" : groupID
                ],
                encoding: URLEncoding.queryString
            )

        case .fetchGroupInfo(let userID, let groupID):
            return .requestParameters(
                parameters: [
                    "groupId" : groupID,
                    "userId" : userID
                ],
                encoding: URLEncoding.queryString
            )

        case .fetchGroupFeeds(let userID, let groupID, let page):
            return .requestParameters(
                parameters: [
                    "groupId" : groupID,
                    "userId" : userID,
                    "page" : page
                ],
                encoding: URLEncoding.queryString
            )

        case .fetchUserGroupsAll(let userID):
            return .requestParameters(
                parameters: [
                    "id" : userID
                ],
                encoding: URLEncoding.queryString
            )

        case .removeMate(let groupID, let userID):
            return .requestParameters(
                parameters: [
                    "userId" : userID
                ],
                encoding: URLEncoding.queryString
            )
        }
    }

    var headers: [String : String]? {
        EnvironmentValue.defaultHeader
    }
}
