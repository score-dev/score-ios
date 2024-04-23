//
//  SettingMainFeature.swift
//  Score
//
//  Created by sole on 4/19/24.
//

import ComposableArchitecture

@Reducer
struct SettingMainFeature {
    @Dependency(\.dismiss) var dismiss
    
    struct State: Equatable {
        @PresentationState var destination: Destination.State?
        @BindingState var isPresentedSignOutDialog: Bool = false 
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case destination(PresentationAction<Destination.Action>)
        case navigationButtonTapped(Navigation.Main)
        
        case alarmSettingViewNavigating
        case blockUserSettingViewNavigating
        case policyViewNavigating
        case unregisterViewNavigating
        case contactViewNavigating
        
        case signOutButtonTapped
        case dismissButtonTapped
        case dialogDismissButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .destination:
                return .none
                
            case .alarmSettingViewNavigating:
                state.destination = .alarmSetting(.init())
                return .none
                
            case .blockUserSettingViewNavigating:
                state.destination = .blockUserSetting(.init())
                return .none
                
            case .policyViewNavigating:
                state.destination = .policy(.init(destination: nil))
                return .none
                
            case .unregisterViewNavigating:
                state.destination = .unregister(.init())
                return .none
                
            case .contactViewNavigating:
                state.destination = .contact(.init())
                return .none
                
            case .signOutButtonTapped:
                state.isPresentedSignOutDialog = true 
                return .none
                
            case .dialogDismissButtonTapped:
                state.isPresentedSignOutDialog = false
                return .none
                
            case .dismissButtonTapped:
                return .run { send in
                    await self.dismiss()
                }
                
            case .navigationButtonTapped(let navigationDestination):
                switch navigationDestination {
                case .alarm:
                    return .send(.alarmSettingViewNavigating)
                case .block:
                    return .send(.blockUserSettingViewNavigating)
                case .policy:
                    return .send(.policyViewNavigating)
                case .unregister:
                    return .send(.unregisterViewNavigating)
                case .contact:
                    return .send(.contactViewNavigating)
                case .signOut:
                    return .send(.signOutButtonTapped)
                }
                
            case .binding:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination) {
            Destination()
        }
    }
    
    //MARK: - Destination
    
    @Reducer
    struct Destination {
        enum State: Equatable {
            case alarmSetting(AlarmSettingFeature.State)
            case blockUserSetting(BlockUserSettingFeature.State)
            case policy(PolicyFeature.State)
            case unregister(UnregisterFeature.State)
            case contact(ContactFeature.State)
            case signOut(SignOutFeature.State)
        }
        
        enum Action {
            case alarmSetting(AlarmSettingFeature.Action)
            case blockUserSetting(BlockUserSettingFeature.Action)
            case policy(PolicyFeature.Action)
            case unregister(UnregisterFeature.Action)
            case contact(ContactFeature.Action)
            case signOut(SignOutFeature.Action)
        }
        
        var body: some ReducerOf<Self> {
            Scope(state: \.alarmSetting,
                  action: \.alarmSetting) {
                AlarmSettingFeature()
            }
            Scope(state: \.blockUserSetting,
                  action: \.blockUserSetting) {
                BlockUserSettingFeature()
            }
            Scope(state: \.policy,
                  action: \.policy) {
                PolicyFeature()
            }
            Scope(state: \.unregister,
                  action: \.unregister) {
                UnregisterFeature()
            }
            Scope(state: \.contact,
                  action: \.contact) {
                ContactFeature()
            }
            Scope(state: \.signOut,
                  action: \.signOut) {
                SignOutFeature()
            }
        }
    }
}
