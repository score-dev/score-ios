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
        case title = "여러분의 소중한 의견을 들려주세요!"
        case subTitle = "더 나은 서비스를 위해 스코어가 힘낼게요:)"
        case textEditorPlaceHolder = "자유롭게 의견을 남겨주세요(500자 이내)"
    }
    
    //MARK: - Policy
    
    enum Policy: String {
        // - FIXME: 내용 추가
        case service = ""
        case privacy
    }
    
    //MARK: - Unregister
    
    enum Unregister: String {
        case title = "탈퇴하려는 이유를 알려주세요"
        case subTitle = "*중복 선택 가능"
        case textFieldPlaceHolder = "기타(탈퇴사유를 입력해주세요)"
    }
}
