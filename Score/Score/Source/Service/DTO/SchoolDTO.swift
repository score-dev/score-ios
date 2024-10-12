//
//  SchoolDTO.swift
//  Score
//
//  Created by sole on 10/10/24.
//

struct SchoolDTO: Encodable {
    let schoolName: String
    let schoolAddress: String
    let schoolCode: String // 학교 행정 표준 번호
}

struct CreateSchoolDTO {
    // TODO: Date format이 어떤 형식인지 iso6801?
    let createdAt: String
    let updatedAt: String
    let createdBy: String
    let lastModifiedBy: String // 이것도 date time?
    let id: Int64
    let schoolName: String
    let schoolLocation: String
    let schoolAddress: String
    let schoolCode: String
}
