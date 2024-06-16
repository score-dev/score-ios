//
//  SCLineTabBarFeature.swift
//  Score
//
//  Created by sole on 4/24/24.
//

import ComposableArchitecture

@Reducer
struct SCLineTabBarFeature<T: SCLineTabProtocol> {
    struct State: Equatable {
        var tabItems: [SCLineTabItem<T>] = []
        @BindingState var selectedTab: T
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case tabBarButtonTapped(SCLineTabItem<T>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case .tabBarButtonTapped(let tabItem):
                state.selectedTab = tabItem.tab
                return .none
            }
        }
    }
}
