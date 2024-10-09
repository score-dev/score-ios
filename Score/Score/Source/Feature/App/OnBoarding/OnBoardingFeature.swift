//
//  OnBoardingFeature.swift
//  Score
//
//  Created by sole on 6/1/24.
//

import ComposableArchitecture

@Reducer
struct OnBoardingFeature {
    struct State: Equatable {
        let totalIndex: Int = 4
        @BindingState var currentTag: Int = 0
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case nextButtonTapped
        case skipButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .nextButtonTapped:
                if state.currentTag+1 < state.totalIndex {
                    state.currentTag += 1
                } else {
                    return .send(.skipButtonTapped)
                }
                return .none
                
            case .skipButtonTapped:
                print("skip button tapped")
                return .none
                
            case .binding(_):
                return .none
            }
        }
    }
}
