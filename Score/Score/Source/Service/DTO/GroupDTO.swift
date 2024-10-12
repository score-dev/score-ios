//
//  GroupDTO.swift
//  Score
//
//  Created by sole on 10/10/24.
//

struct CreateGroupDTO: Encodable {
    let groupImg: String
    // 최소 1자 최대 15자
    let groupName: String
    // 최소 1자 최대 15자 -> 피그마와 다른데 확인 필요
    let groupDescription: String
    // private section
    let groupPassword: String?
    let `private`: Bool
    // TODO: 이건 무슨 속성인지 확인 필요
    let valid: Bool
}
