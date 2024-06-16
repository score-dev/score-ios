//
//  SignOutFeature.swift
//  Score
//
//  Created by sole on 4/21/24.
//

import ComposableArchitecture

@Reducer
struct SignOutFeature {
    @Dependency(\.dismiss) var dismiss
    
    struct State: Equatable {
        
    }
    
    enum Action {
        case dismissButtonTapped
        case signOutButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .dismissButtonTapped:
                return .run { send in
                    await self.dismiss()
                }
                
            case .signOutButtonTapped:
                return .none
            }
        }
    }
    
}
