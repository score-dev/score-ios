//
//  WalkingDTO.swift
//  Score
//
//  Created by sole on 10/10/24.
//

struct WalkingDTO: Encodable {
    /// 운동을 시작한 시각
    let startedAt: String
    /// 운동을 끝낸 시각
    let completedAt: String
    /// 운동 시작한 유저의 ID
    let agentId: Int64
    /// 함께 운동한 유저들의 ID값 배열 
    let othersId: [Int64]
    /// 운동한 거리
    let distance: Double
    /// 운동한 동안 소모한 칼로리
    let reducedKcal: Int32
    /// 운동 장소
    let location: String
    let weather: String
    let temperature: Int32
    /// 미세먼지 농도
    let fineDust: String
    /// 오늘의 감정
    let feeling: String
}
