//
//  TabRouteView.swift
//  Score
//
//  Created by sole on 4/24/24.
//

import ComposableArchitecture
import SwiftUI

//MARK: - TabRouteView

struct TabRouteView: View {
    let store: StoreOf<SCTabBarFeature>
    @ObservedObject var viewStore: ViewStoreOf<SCTabBarFeature>
    
    init(store: StoreOf<SCTabBarFeature>) {
        self.store = store
        self.viewStore = ViewStore(store,
                                   observe: { $0 })
    }
    
    var body: some View {
        TabView(selection: viewStore.$selectedTab) {
            HomeMainView(store: store.scope(state: \.home,
                                            action: \.home))
            .tag(SCTabItem.home)
            
            SchoolGroupMainView(
                store: self.store.scope(
                    state: \.schoolGroup,
                    action: \.schoolGroup)
            )
            
            .tag(SCTabItem.schoolGroup)
        }
        .scTabBar(store: store)
        .onAppear {
            store.send(.viewAppearing)
        }
        .fullScreenCover(
            store: store.scope(
                state: \.$destination.record,
                action: \.destination.record)
        ) { store in
            NavigationStack {
                TimerRecordView(store: store)
            }
        }
    }
}

//MARK: - Preview

#Preview {
    NavigationStack {
        TabRouteView(
            store: .init(initialState: .init(selectedTab: .home),
                         reducer: { SCTabBarFeature() }))
    }
}
