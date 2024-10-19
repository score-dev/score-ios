//
//  SchoolAPIDTO.swift
//  Score
//
//  Created by sole on 10/19/24.
//

struct SchoolAPIDTO: Codable {
    let schoolInfo: [SchoolInfo]
}

struct SchoolInfo: Codable {
    let head: [Head]?
    let row: [SchoolRow]?
}

struct Head: Codable {
    let listTotalCount: Int?
    let result: Result?

    enum CodingKeys: String, CodingKey {
        case listTotalCount = "list_total_count"
        case result = "RESULT"
    }
}

struct SchoolRow: Codable {
    let schoolCode: String
    let schoolName: String
    let schoolAddress: String

    enum CodingKeys: String, CodingKey {
        case schoolCode = "SD_SCHUL_CODE"
        case schoolName = "SCHUL_NM"
        case schoolAddress = "ORG_RDNMA"
    }
}

struct Result: Codable {
    let code, message: String

    enum CodingKeys: String, CodingKey {
        case code = "CODE"
        case message = "MESSAGE"
    }
}
