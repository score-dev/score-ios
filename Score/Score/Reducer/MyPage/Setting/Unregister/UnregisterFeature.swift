//
//  UnregisterFeature.swift
//  Score
//
//  Created by sole on 4/19/24.
//

import ComposableArchitecture

@Reducer
struct UnregisterFeature {
    @Dependency(\.dismiss) var dismiss
    
    struct State: Equatable {
        var unregisterReasons: Set<UnregisterReason> = .init()
        @BindingState var ectUnregisterReason: String = ""
        var isDisableUnregisterButton: Bool = true
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case reasonButtonTapped(UnregisterReason)
        case unRegisterButtonDisableStatusChanging
        case unregisterButtonTapped
        case dismissButtonTapped
        case ectReasonTextFieldClearButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .reasonButtonTapped(let reason):
                if state.unregisterReasons.contains(reason) {
                    state.unregisterReasons.remove(reason)
                } else {
                    state.unregisterReasons.insert(reason)
                }
                return .send(.unRegisterButtonDisableStatusChanging)
                
            case .unRegisterButtonDisableStatusChanging:
                if state.unregisterReasons.isEmpty,
                   state.ectUnregisterReason.isEmpty {
                    state.isDisableUnregisterButton = true
                } else {
                    state.isDisableUnregisterButton = false
                }
                return .none
                
            case .unregisterButtonTapped:
                // remote 탈퇴 과정 거치기 -> Main 화면으로 이동
                return .none
                
            case .dismissButtonTapped:
                return .run { send in
                    await self.dismiss()
                }
            case .ectReasonTextFieldClearButtonTapped:
                state.ectUnregisterReason = ""
                return .send(.unRegisterButtonDisableStatusChanging)
                
            case .binding(\.$ectUnregisterReason):
                return .send(.unRegisterButtonDisableStatusChanging)
                
            case .binding(_):
                return .none
            }
        }
    }
}
