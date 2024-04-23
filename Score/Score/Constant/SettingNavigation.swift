//
//  Navigation.swift
//  Score
//
//  Created by sole on 4/16/24.
//

import Foundation

//MARK: - Navigation

enum Navigation {
    enum Main: String,
               CaseIterable {
        case alarm = "알림설정"
        case block = "차단한 메이트 관리하기"
        case contact = "문의하기"
        case policy = "이용약관"
        case signOut = "로그아웃"
        case unregister = "탈퇴하기"
    }
    
    enum Policy: String {
        case service = "이용약관"
        case privacy = "개인정보처리방침"
    }
    
    enum Alarm: String,
                CaseIterable {
        case all = "전체알림"
        case notice = "공지사항"
        case follow = "소통"
        case workOutTime = "목표운동시간"
        
        var subTitle: String {
            switch self {
            case .all:
                return ""
            case .notice:
                return "업데이트 소식, 이벤트, 마케팅 등 알림 제공"
            case .follow:
                return "좋아요, 팔로우, 태그 알림 제공"
            case .workOutTime:
                return "목표 운동 시간마다 푸시 알림 제공"
            }
        }
    }
    
}
