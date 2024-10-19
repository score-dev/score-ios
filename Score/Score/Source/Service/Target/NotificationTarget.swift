//
//  NotificationTarget.swift
//  Score
//
//  Created by sole on 10/20/24.
//

import Foundation
import Moya

enum NotificationTarget: TargetType {
    /// fcmTokenData는 fcmToken을 JSON 형태로 인코딩한 Data입니다.
    case getFCMToken(userID: Int64, fcmTokenData: Data)
    /// 알림을 전송합니다.
    /// fcmRequestDTOData는 FCMRequestDTO를 인코딩한 Data입니다.
    case sendNotification(fcmRequestDTOData: Data)
    /// 알림을 삭제합니다.
    case deleteNotification(notificationID: Int64)
    /// 알림 목록을 불러옵니다.
    case fetchNotifications(userID: Int64, page: Int32)

    var baseURL: URL {
        EnvironmentValue.baseURL
    }

    var path: String {
        switch self {
        case .getFCMToken(let userID, _):
            "score/\(userID)/token"
        case .sendNotification:
            "score/fcm"
        case .deleteNotification:
            "score/fcm/delete"
        case .fetchNotifications:
            "score/fcm/list"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getFCMToken: .post
        case .sendNotification: .post
        case .deleteNotification: .post
        case .fetchNotifications: .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .getFCMToken(let userID, let fcmTokenData):
            return .requestCompositeData(
                bodyData: fcmTokenData,
                urlParameters: [
                    "userId" : userID
                ]
            )

        case .sendNotification(let fcmRequestDTOData):
            return .requestParameters(
                parameters: [
                    "fcmMessageRequest" : fcmRequestDTOData
                ],
                encoding: URLEncoding.queryString
            )

        case .deleteNotification(let notificationID):
            return .requestParameters(
                parameters: [
                    "notificationId" : notificationID
                ],
                encoding: URLEncoding.queryString
            )

        case .fetchNotifications(let userID, let page):
            return .requestParameters(
                parameters: [
                    "userId" : userID,
                    "page" : page
                ],
                encoding: URLEncoding.queryString
            )
        }
    }

    var headers: [String : String]? {
        EnvironmentValue.defaultHeader
    }
}
