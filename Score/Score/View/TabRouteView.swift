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
    
    var body: some View {
        NavigationStackStore(
            store.scope(state: \.path,
                        action: \.path)
        ) {
            WithPerceptionTracking {
                Text("Root View")
                    .onAppear {
                        store.send(.viewAppearing)
                    }
                    .fullScreenCover(
                        store: store.scope(
                            state: \.$destination.record,
                            action: \.destination.record)
                    ) { store in
                        RecordMainView(store: store)
                    }
            }
        } destination: { store in
            switch store.state {
            case .home:
                if let store = store.scope(state: \.home,
                                           action: \.home) {
                    HomeMainView(store: store)
                        .scTabBar(store: self.store)
                }
            case .schoolGroup:
                if let store = store.scope(state: \.schoolGroup,
                                           action: \.schoolGroup) {
                    SchoolGroupMainView(store: store)
                        .scTabBar(store: self.store)
                }
            }
        }
    }
}

//MARK: - Preview

#Preview {
    TabRouteView(
        store: .init(initialState: .init(selectedTab: .home),
        reducer: { SCTabBarFeature() }))
}
