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

@Reducer
struct AuthFeature {
    struct State: Equatable {
        var authCenter: AuthCenter? = nil
        
        var isSignIn: Bool = false
        var isLoading: Bool = false
        
        var isPresentingSignInErrorAlert: Bool = false
    }
    
    enum Action {
        case googleSingInButtonTapped
        case appleSignInButtonTapped
        case kakaoSignInButtonTapped
        case signInWithServer(AuthToken)
        case errorAppearing(Error)
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
                return .none
                
            case .appleSignInButtonTapped:
                return .none
                
            case .signInWithServer(let token):
                state.isLoading = false
                return .none
                
            case .errorAppearing(let error):
                state.isLoading = false
                return .none
            }
        }
    }
}
