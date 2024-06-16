//
//  FeedMainFeature.swift
//  Score
//
//  Created by sole on 4/27/24.
//

import ComposableArchitecture

@Reducer
struct FeedMainFeature {
    struct State: Equatable {
        
    }
    
    enum Action {
        case viewAppearing
        case feedImageButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppearing:
                return .none
                
            case .feedImageButtonTapped:
                return .none
            }
        }
    }
    
}
