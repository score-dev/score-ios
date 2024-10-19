//
//  UserTarget.swift
//  Score
//
//  Created by sole on 10/10/24.
//

import Moya 
import Foundation

enum UserTarget {
    case updateUserInfo(userID: Int64, updateUserDTOData: Data)
    case updateNotificationSetting(notificationDTOData: Data)
    case registerUser(registerUserDTOData: Data)
    /// 닉네임 중복 검사를 요청합니다.
    case checkNicknameDuplicate(nickName: String)
    /// 메인 페이지 접속 요청 발생시 jwt 토큰을 검증합니다.
    case validateAccessToken(accessToken: String)
    /// 소셜 로그인 인증 완료 후 기존 회원인지 여부를 확인합니다.
    case auth(providerID: String)
    case withdrawUser(userID: Int64, reason: String)
    case reportUser(reportUserDTOData: Data)
}

extension UserTarget: TargetType {
    var baseURL: URL {
        Environment.baseURL.appending(path: "score")
    }

    var path: String {
        switch self {
        case .updateUserInfo(let userID, _):
            "user/update/\(userID)"
        case .updateNotificationSetting:
            "user/setting/notification"
        case .registerUser:
            "onboarding/fin"
        case .checkNicknameDuplicate(let nickName):
            "\(nickName)/exists"
        case .validateAccessToken:
            "main"
        case .auth:
            "auth"
        case .withdrawUser:
            "user/withdrawal"
        case .reportUser:
            "user/report"
        }
    }

    var method: Moya.Method {
        switch self {
        case .updateUserInfo: .put
        case .updateNotificationSetting: .put
        case .registerUser: .post
        case .checkNicknameDuplicate: .get
        case .validateAccessToken: .get
        case .auth: .get
        case .withdrawUser: .delete
        case .reportUser: .post
        }
    }

    var task: Moya.Task {
        switch self {
        case .updateUserInfo(let userID, let updateUserDTOData):
            return .requestData(updateUserDTOData)

        case .updateNotificationSetting(let notificationDTOData):
            return .requestParameters(
                parameters: [
                    "request" : notificationDTOData
                ],
                encoding: URLEncoding.queryString
            )

        case .registerUser(let registerUserDTOData):
            return .requestData(registerUserDTOData)

        case .checkNicknameDuplicate:
            return .requestPlain

        case .validateAccessToken:
            return .requestPlain

        case .auth(let providerID):
            return .requestParameters(
                parameters: [
                    "id" : providerID
                ],
                encoding: URLEncoding.queryString
            )

        case .withdrawUser(let userID, let reason):
            return .requestParameters(
                parameters: [
                    "id" : userID,
                    "reason" : reason
                ],
                encoding: URLEncoding.queryString
            )
            
        case .reportUser(let reportUserDTOData):
            return .requestData(reportUserDTOData)
        }
    }

    var headers: [String : String]? {
        var defaultHeader = Environment.defaultHeader
        if case .validateAccessToken(let accessToken) = self {
            defaultHeader.merge(["Authorization" : "Bearer \(accessToken)"])
        }
        return defaultHeader
    }
}
