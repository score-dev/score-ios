//
//  TypeNickNameFeature.swift
//  Score
//
//  Created by sole on 6/6/24.
//

import ComposableArchitecture

@Reducer
struct TypeNickNameFeature {
    struct State: Equatable {
        @BindingState var nickName: String = ""
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case tappedNextStepButton
        case tappedDismissButton
        case tappedSkipButton
        case textFieldClearButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .tappedNextStepButton:
                return .none
            case .tappedDismissButton:
                return .none
            case .tappedSkipButton:
                return .none
            case .textFieldClearButtonTapped:
                
                return .none
            case .binding:
                return .none
            }
        }
    }
}
