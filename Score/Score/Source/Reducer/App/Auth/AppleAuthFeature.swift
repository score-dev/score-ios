//
//  AppleAuthFeature.swift
//  Score
//
//  Created by sole on 5/27/24.
//

import ComposableArchitecture
import AuthenticationServices

@Reducer
struct AppleAuthFeature {
    struct State: Equatable {}
    
    enum Action {
        // user action
        case signIn
        case signOut
        case signUp
        // delegate action
        case didCompleteWithAuthorization(ASAuthorizationAppleIDCredential)
        case didCompleteWithError(Error)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .signIn:
                AppleAuthStore.shared.signIn()
                return .none
                
            case .signOut:
                AppleAuthStore.shared.signOut()
                return .none
                
            case .signUp:
                return .none
                
            case .didCompleteWithAuthorization(let authorization):
                // 이후에 처리 필요
                return .none
            case .didCompleteWithError(let error):
                // 이후에 처리 필요 
                return .none
            }
        }
    }
}
