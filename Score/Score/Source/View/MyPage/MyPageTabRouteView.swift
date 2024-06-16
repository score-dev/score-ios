//
//  MyPageTabRouteView.swift
//  Score
//
//  Created by sole on 4/24/24.
//

import ComposableArchitecture
import SwiftUI

//MARK: - MyPageTabRouteView

struct MyPageTabRouteView: View {
    typealias Tab = MyPageMainFeature.MyPageLineTab
    let store: StoreOf<MyPageMainFeature>
    @ObservedObject var viewStore: ViewStoreOf<SCLineTabBarFeature<Tab>>
    
    //MARK: - init
    
    init(store: StoreOf<MyPageMainFeature>) {
        self.store = store
        self.viewStore = ViewStore(
            store.scope(state: \.lineTabBar,
                        action: \.lineTabBar),
            observe: { $0 })
    }
    
    //MARK: - body
    
    var body: some View {
        TabView(selection: viewStore.$selectedTab
        ) {
            FeedGridView(store: store.scope(state: \.feed,
                                            action: \.feed)
            )
            .tag(Tab.feed)
            
            VStack {
                CalendarView(
                    store: store.scope(state: \.calendar,
                                       action: \.calendar)
                )
                Spacer()
            }
            .padding(.top, 30)
            .tag(Tab.calendar)
        }
        .scLineTabBar(
            store: store.scope(state: \.lineTabBar,
                               action: \.lineTabBar))
        .tabViewStyle(
            .page(indexDisplayMode: .never)
        )
    }
}

//MARK: - Preview

#Preview {
    MyPageTabRouteView(store: .init(initialState: .init(),
                                    reducer: { MyPageMainFeature() }))
}
