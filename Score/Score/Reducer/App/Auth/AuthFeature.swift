//
//  AuthFeature.swift
//  Score
//
//  Created by sole on 5/21/24.
//

import ComposableArchitecture
import Foundation
import KakaoSDKAuth
import KakaoSDKUser
import SwiftUI
import AuthenticationServices

@Reducer
struct AuthFeature {
    struct State: Equatable {
        var authCenter: AuthCenter? = nil
        
        var isSignIn: Bool = false
        var isLoading: Bool = false
        
        var isPresentingSignInErrorAlert: Bool = false
        
        /// delegate 적용을 위해 AppleAuthFeature를 따로 구현합니다.
        var appleAuth: AppleAuthFeature.State = .init()
    }
    
    enum Action {
        case googleSingInButtonTapped
        case appleSignInButtonTapped
        case kakaoSignInButtonTapped
        case signInWithServer(AuthToken)
        case errorAppearing(Error)
        
        /// delegate 적용을 위해 AppleAuthFeature를 따로 구현합니다.
        case appleAuth(AppleAuthFeature.Action)
    }
    
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .kakaoSignInButtonTapped:
                state.isLoading = true
                return .run { send in
                    do {
                        let token = try await KakaoLoginStore.shared.signIn()
                        await send(.signInWithServer(token))
                    } catch {
                        await send(.errorAppearing(error))
                    }
                }
                
            case .googleSingInButtonTapped:
                state.isLoading = true
                return .none
                
            case .appleSignInButtonTapped:
                state.isLoading = true
                return .send(.appleAuth(.signIn))
                
            case .signInWithServer(let token):
                state.isLoading = false
                return .none
                
            case .errorAppearing(let error):
                print(error.localizedDescription)
                state.isLoading = false
                return .none
                
            case .appleAuth(let appleAction):
                switch appleAction {
                case .didCompleteWithAuthorization(let authorization):
                    let token = AuthToken(accessToken: "apple",
                                          refreshToken: "apple")
                    return .send(.signInWithServer(token))
                    
                case .didCompleteWithError(let error):
                    return .send(.errorAppearing(error))
                    
                case .signIn, .signOut, .signUp:
                    return .none
                }
            }
        }
        
        /// delegate 적용을 위해 AppleAuthFeature를 따로 구현합니다.
        Scope(state: \.appleAuth, action: \.appleAuth) {
            AppleAuthFeature()
        }
    }
}
