//
//  Contexts.swift
//  Score
//
//  Created by sole on 4/16/24.
//

import Foundation

//MARK: - Contexts

enum Contexts {
    //MARK: - MyPage
    
    enum MyPage: String {
        case nickNamePlaceHolder = "현재 닉네임"
        case heightPlaceHolder = "000cm"
        case weightPlaceHolder = "00kg"
    }
    
    //MARK: - Cantact
    
    enum Cantact: String {
        case recipient = "score-official@gmail.com"
        case subject = "[문의] 스코어 앱 관련 문의합니다."
        case messageBody = ""
        case guide = "문의주세요."
    }
    
    //MARK: - Policy
    
    enum Policy: String {
        // - FIXME: 내용 추가
        case service = ""
        case privacy
    }
    
    enum SignOut: String {
        case guide = 
        """
            정말 로그아웃하시겠어요? 데이터는 그대로 남아있지만 푸시알림은 받을 수 없어요.
        """
    }
    
    //MARK: - Unregister
    
    enum Unregister: String {
        case title = "탈퇴하려는 이유를 알려주세요"
        case subTitle = "*중복 선택 가능"
        case textFieldPlaceHolder = "기타(탈퇴사유를 입력해주세요)"
    }
}
