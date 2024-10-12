//
//  UserDTO.swift
//  Score
//
//  Created by sole on 10/10/24.
//

struct UserDTO: Codable {
    /// 최대 길이 10
    let nickname: String
    let grade: Int32
    let height: Int32
    let weight: Int32
    /// 파스칼로 작성 ex. FEMALE MALE, FEMALE, NONE
    let gender: String
    let goal: LocalTime // 운동 목표 시간
    let marketing: Bool // 마케팅 알림 수신 동의 여부
    let exercisingTime: Bool // 운동 시간 알림 동의 여부
    let loginKey: String // providerID

}

struct WithdrawUserDTO: Encodable {
    let id: Int64
    let reason: String
}

// 업데이트 대상이 하나만 가능한지 확인 
struct UpdateUserDTO: Encodable {
    let nickname: String?
    let school: SchoolDTO?
    let weight: Int32?
    let height: Int32?
    let goal: LocalTime?
}

struct ReportUserDTO: Encodable {
    // TODO: 각각이 무슨 필드인지 확인 필요
    let agentId: Int64
    let objectId: Int64
    // TODO: 두 개가 무슨 차이인지 확인 필요
    let reportReason: String // 선택 부분?
    let comment: String // etc 쓰는 부분?
}

struct AuthDTO: Encodable {
    let id: Int64 // providerID
}

// all user data 
//User{
//createdAt    [...]
//updatedAt    [...]
//createdBy    [...]
//lastModifiedBy    [...]
//id    [...]
//nickname    [...]
//school    School{...}
//schoolUpdatedAt    [...]
//gender    [...]
//grade    [...]
//height    [...]
//weight    [...]
//profileImg    [...]
//goal    LocalTime{...}
//level    [...]
//point    [...]
//lastExerciseDateTime    [...]
//consecutiveDate    [...]
//weeklyCumulativeTime    [...]
//weeklyExerciseCount    [...]
//weeklyLevelIncrement    [...]
//totalCumulativeTime    [...]
//cumulativeDistance    [...]
//marketing    [...]
//exercisingTime    [...]
//tag    [...]
//refreshToken    [...]
//loginKey    [...]
//fcmToken    [...]
//joinedAt    [...]
//profileImageUrl    [...]
//schoolAndStudent    School{...}
//notificationReceivingStatus    NotificationStatusRequest{...}
//}
