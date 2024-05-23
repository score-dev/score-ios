//
//  UserApi+.swift
//  Score
//
//  Created by sole on 5/21/24.
//

import Foundation
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

//MARK: - UserApi+

extension UserApi {
    //MARK: - async loginWithKakaoTalk
    
    @MainActor
    func loginWithKakaoTalk() async throws -> OAuthToken? {
        try await withCheckedThrowingContinuation { continuation in
            /// Thread 1: Fatal error: SWIFT TASK CONTINUATION MISUSE: loginWithKakaoAccount() tried to resume its continuation more than once, returning nil! 해결을 위해 임시 변수를 삽입합니다.
            var isResumed = false
            
            self.loginWithKakaoTalk { token, error in
                guard !isResumed
                else { return }
                
                if let error {
                    continuation.resume(throwing: error)
                } else if let token {
                    continuation.resume(returning: token)
                } else {
                    continuation.resume(
                        throwing: KakaoSDKCommon.SdkError.ApiFailed(
                            reason: .Unknown,
                            errorInfo: nil
                        )
                    )
                }
                isResumed = true
            }
        }
    }
    
    //MARK: - async loginWithKakaoAccount

    @MainActor
    func loginWithKakaoAccount() async throws -> OAuthToken? {
        try await withCheckedThrowingContinuation { continuation in
            /// Thread 1: Fatal error: SWIFT TASK CONTINUATION MISUSE: loginWithKakaoAccount() tried to resume its continuation more than once, returning nil! 해결을 위해 임시 변수를 삽입합니다.
            var isResumed = false
            
            self.loginWithKakaoAccount { token, error in
                // 이미 resume이 한번 호출되었으면, resume을 실행하지 않습니다.
                guard !isResumed
                else { return }
                
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let token = token {
                    continuation.resume(returning: token)
                } else {
                    continuation.resume(
                        throwing: KakaoSDKCommon.SdkError.ApiFailed(
                            reason: .Unknown,
                            errorInfo: nil
                        )
                    )
                }
                isResumed = true
            }
        }
    }
    
    //MARK: - async logout
    
    @MainActor
    func logout() async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            self.logout { error in
                if let error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: ())
                }
            }
        }
    }
}
