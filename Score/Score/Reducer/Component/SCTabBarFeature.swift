//
//  SCTabBarFeature.swift
//  Score
//
//  Created by sole on 4/24/24.
//

import ComposableArchitecture

//MARK: - SCTabBarFeature

@Reducer
struct SCTabBarFeature {
    
    struct State: Equatable {
        @BindingState var selectedTab: SCTabItem = .home
        @PresentationState var destination: Destination.State?
        
        var home: HomeMainFeature.State = .init()
        var schoolGroup: SchoolGroupMainFeature.State = .init()
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case viewAppearing
        case tabItemButtonTapped(SCTabItem)
        case destination(PresentationAction<Destination.Action>)
        
        case home(HomeMainFeature.Action)
        case schoolGroup(SchoolGroupMainFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .viewAppearing:
                return .none
                
            case .tabItemButtonTapped(let tabItem):
                switch tabItem {
                case .home:
                    state.selectedTab = tabItem
                    
                case .schoolGroup:
                    state.selectedTab = tabItem
                    
                case .record:
                    state.destination = .record(.init())
                }
                return .none
                
            case .binding,
                    .destination:
                return .none
            }
        }
        .ifLet(\.$destination,
                action: \.destination) {
            Destination()
        }
    }
    
    //MARK: - Destination
    
    @Reducer
    struct Destination {
        enum State: Equatable {
            case record(RecordMainFeature.State)
        }
        
        enum Action {
            case record(RecordMainFeature.Action)
        }
        
        var body: some ReducerOf<Self> {
            Scope(state: \.record, action: \.record) {
                RecordMainFeature()
            }
        }
    }
}
