//
//  SettingNavigation.swift
//  Score
//
//  Created by sole on 4/16/24.
//

import Foundation

//MARK: - Setting

enum SettingNavigation {
    enum Main: String,
               CaseIterable {
        case alarm = "알림설정"
        case block = "차단한 메이트 관리하기"
        case contact = "문의하기"
        case policy = "이용약관"
        case signOut = "로그아웃"
        case unregister = "탈퇴하기"
    }
    
    enum Alarm: String,
                CaseIterable {
        case all = "전체알림"
        case notice = "공지사항"
        case follow = "소통"
        case workOutTime = "목표운동시간"
    }
    
}
