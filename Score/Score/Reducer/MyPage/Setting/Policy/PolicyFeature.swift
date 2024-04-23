//
//  PolicyFeature.swift
//  Score
//
//  Created by sole on 4/21/24.
//

import ComposableArchitecture

@Reducer
struct PolicyFeature {
    @Dependency(\.dismiss) var dismiss
    
    struct State: Equatable {
        @PresentationState var destination: Destination.State?
    }
    
    enum Action {
        case destination(PresentationAction<Destination.Action>)
        case servicePolicyButtonTapped
        case privacyPolicyButtonTapped
        case dismissButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .destination:
                return .none 
                
            case .servicePolicyButtonTapped:
                state.destination = .service(.init())
                return .none
                
            case .privacyPolicyButtonTapped:
                state.destination = .privacy(.init())
                return .none
                
            case .dismissButtonTapped:
                return .run { send in
                    await self.dismiss()
                }
            }
        }
        .ifLet(\.$destination, action: /Action.destination) {
            Destination()
        }
    }
    
    @Reducer
    struct Destination {
        enum State: Equatable {
            case service(ServicePolicyFeature.State)
            case privacy(PrivacyPolicyFeature.State)
        }
        
        enum Action {
            case service(ServicePolicyFeature.Action)
            case privacy(PrivacyPolicyFeature.Action)
        }
        
        var body: some ReducerOf<Self> {
            Scope(state: /State.service, action: /Action.service) {
                ServicePolicyFeature()
            }
            Scope(state: /State.privacy, action: /Action.privacy) {
                PrivacyPolicyFeature()
            }
        }
    }
}
