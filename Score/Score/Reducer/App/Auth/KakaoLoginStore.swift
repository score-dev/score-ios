//
//  KakaoLoginStore.swift
//  Score
//
//  Created by sole on 5/21/24.
//

import Foundation
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

//MARK: - KakaoLoginStore

/// 카카오 인증 싱글톤 객체입니다.
final class KakaoLoginStore {
    static let shared: KakaoLoginStore = .init()
    
    private init() {}
    
    //MARK: - signIn
    
    /// 카카오로 로그인합니다. SDK를 통해 받은 Token을 서버에 보내는 형태로 변환하여 반환합니다.
    func signIn() async throws -> AuthToken {
        let authToken: AuthToken
        
        // 카카오톡 로그인 가능 여부로 분기처리
        if UserApi.isKakaoTalkLoginAvailable() {
            guard let token = try await UserApi.shared.loginWithKakaoTalk()
            else {
                throw KakaoSDKCommon.SdkError.AuthFailed(reason: .Unknown,
                                                         errorInfo: nil)
            }
            // FIXME: 데이터 구조 확인 후 수정 필요
            authToken = .init(
                accessToken: token.accessToken,
                refreshToken: token.refreshToken
            )
        } else {
            guard let token = try await UserApi.shared.loginWithKakaoAccount()
            else {
                throw KakaoSDKCommon.SdkError.AuthFailed(reason: .Unknown,
                                                         errorInfo: nil)
            }
            
            // FIXME: 데이터 구조 확인 후 수정 필요
            authToken = .init(
                accessToken: token.accessToken,
                refreshToken: token.refreshToken
            )
        }
        return authToken
    }
    
    //MARK: - signOut
    
    /// 로그아웃
    func signOut() async throws {
        try await UserApi.shared.logout()
    }
}
