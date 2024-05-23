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
    let gender: Gender
    let height: Int
    let weight: Int
    let schoolName: String
    let grade: Int
    // 운동 알림 시간?
    
    //MARK: - defaultModel
    
    static let defaultModel: User = .init(nickName: "왕감자",
                                          profileImageName: "",
                                          gender: .female,
                                          height: 160,
                                          weight: 50,
                                          schoolName: "감자대학교",
                                          grade: 1)
}

//MARK: - Gender

enum Gender: String, CaseIterable {
    static let sex: [Gender] = [.male,
                                .female]
    
    case male = "남"
    case female = "여"
    case ect
}
