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
    @ObservableState
    struct State: Equatable {
        var selectedTab: SCTabItem = .home
        var path = StackState<Path.State>()
        @Presents var destination: Destination.State?
    }
    
    enum Action {
        case viewAppearing
        case tabItemButtonTapped(SCTabItem)
        case path(StackAction<Path.State, Path.Action>)
        case destination(PresentationAction<Destination.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppearing:
                state.selectedTab = .home
                return .send(.tabItemButtonTapped(.home))
                
            case .tabItemButtonTapped(let tabItem):
                switch tabItem {
                case .home:
                    state.path.removeAll()
                    state.path.append(.home(.init()))
                    state.selectedTab = tabItem
                case .schoolGroup:
                    state.path.removeAll()
                    state.path.append(.schoolGroup(.init()))
                    state.selectedTab = tabItem
                case .record:
                    state.destination = .record(.init())
                }
                
                return .none
                
            case .path:
                return .none
                
            case .destination:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            Path()
        }
        .ifLet(\.$destination, action: \.destination) {
            Destination()
        }
    }
    
    //MARK: - Destination
    
    @Reducer
    struct Path {
        @ObservableState
        enum State: Equatable {
            case home(HomeMainFeature.State)
            case schoolGroup(SchoolGroupMainFeature.State)
        }
        
        enum Action {
            case home(HomeMainFeature.Action)
            case schoolGroup(SchoolGroupMainFeature.Action)
        }
        
        var body: some ReducerOf<Self> {
            Scope(state: \.home, action: \.home) {
                HomeMainFeature()
            }
            
            Scope(state: \.schoolGroup, action: \.schoolGroup) {
                SchoolGroupMainFeature()
            }
        }
    }
    
    //MARK: - Destination
    
    @Reducer
    struct Destination {
        @ObservableState
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
