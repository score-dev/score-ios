//
//  UserTarget.swift
//  Score
//
//  Created by sole on 10/10/24.
//

import Moya 
import Foundation

enum UserTarget {
    case signUp
    case signIn
    case signOut
    case withdraw
    case update // user 정보
}

// TODO: 해당 내용 채워야 함. 
extension UserTarget: TargetType {
    var baseURL: URL {
        .applicationDirectory
    }
    var path: String {
        ""
    }
    var method: Moya.Method {
        switch self {
        case .signUp:
            break
        case .signIn:
            break
        case .signOut:
            break
        case .withdraw:
            break
        case .update:
            break
        }
        return .get
    }
    var task: Moya.Task {
        switch self {
        case .signUp:
            break
        case .signIn:
            break
        case .signOut:
            break
        case .withdraw:
            break
        case .update:
            break
        }
        return .requestPlain
    }
    var headers: [String : String]? {
        switch self {
        case .signUp:
            break
        case .signIn:
            break
        case .signOut:
            break
        case .withdraw:
            break
        case .update:
            break
        }
        return nil
    }
}
