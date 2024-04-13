//
//  User.swift
//  Score
//
//  Created by sole on 4/12/24.
//

import Foundation

//MARK: - User

struct User: Equatable,
             Hashable {
    // identifier
    let nickName: String
    let profileImageName: String
    let sex: Sex
    let height: Int
    let weight: Int
    let schoolName: String
    let grade: Int
    // 운동 알림 시간?
    
    //MARK: - defaultModel
    
    static let defaultModel: User = .init(nickName: "왕감자",
                                          profileImageName: "",
                                          sex: .female,
                                          height: 160,
                                          weight: 50,
                                          schoolName: "감자대학교",
                                          grade: 1)
}

//MARK: - Sex

enum Sex: String {
    case male = "남"
    case female = "여"
}
