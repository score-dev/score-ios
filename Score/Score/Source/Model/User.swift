//
//  User.swift
//  Score
//
//  Created by sole on 4/12/24.
//

import Foundation

//MARK: - User

struct User: Equatable,
             Hashable,
             Codable {
    // identifier
    var nickName: String
    var profileImageName: String?
    var gender: Gender?
    var height: Int?
    var weight: Int?
    var schoolName: String
    var grade: Int
    // 운동 알림 시간?
    
    //MARK: - defaultModel
    
    static let defaultModel: User = .init(nickName: "왕감자",
                                          profileImageName: "",
                                          gender: .female,
                                          height: 160,
                                          weight: 50,
                                          schoolName: "감자대학교",
                                          grade: 1)
    
//    //MARK: - CodingKeys
//    
//    enum CodingKeys: String,
//                     CodingKey {
//        case nickname
//        case profileImageName
//        case gender
//        case height
//        case weight
//        case schoolName
//        case grade
//    }
}

//MARK: - Gender

enum Gender: String,
             CaseIterable,
             Codable {
    static let sex: [Gender] = [.male,
                                .female]
    
    case male = "남"
    case female = "여"
    case ect
}
