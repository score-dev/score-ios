//
//  SCLineTabBar.swift
//  Score
//
//  Created by sole on 4/14/24.
//

import ComposableArchitecture
import SwiftUI

protocol SCLineTabBarItemProtocol: Hashable  {
    associatedtype Tab: SCLineTabProtocol
    
    var title: String { get set }
    var tab: Tab { get set }
}

protocol SCLineTabProtocol: Hashable,
                            Equatable,
                            CaseIterable {
}

struct SCLineTabItem<Tab: SCLineTabProtocol>: SCLineTabBarItemProtocol {
    var title: String
    var tab: Tab
}


//MARK: - SCLineTabBar

struct SCLineTabBar<Tab: SCLineTabProtocol>: View {
    let store: StoreOf<SCLineTabBarFeature<Tab>>
    @ObservedObject var viewStore: ViewStoreOf<SCLineTabBarFeature<Tab>>
    
    //MARK: - init
    
    init(store: StoreOf<SCLineTabBarFeature<Tab>>) {
        self.store = store
        self.viewStore = ViewStore(store,
                                   observe: { $0 })
    }
    
    var body: some View {
        // - FIXME: 디자인 상의 필요, animation 적용
        HStack(spacing: 50) {
            ForEach(viewStore.tabItems,
                    id: \.self) { item in
                Text("\(item.title)")
                    .modifier(
                        SCLineTabBarItemViewModifier(
                            store: store,
                            item: item
                        )
                    )
            }
        }
        .frame(maxWidth: .infinity)
    }
}

//MARK: - SCLineTabBarItemViewModifier

struct SCLineTabBarItemViewModifier<Tab: SCLineTabProtocol>: ViewModifier {
    let store: StoreOf<SCLineTabBarFeature<Tab>>
    let item: SCLineTabItem<Tab>
    
    @ObservedObject var viewStore: ViewStoreOf<SCLineTabBarFeature<Tab>>
    
    //MARK: - init
    
    init(store: StoreOf<SCLineTabBarFeature<Tab>>,
         item: SCLineTabItem<Tab>) {
        self.store = store
        self.viewStore = ViewStore(store,
                                   observe: { $0 })
        self.item = item
    }
    
    func body(content: Content) -> some View {
        Button {
            viewStore.send(.tabBarButtonTapped(item),
                           animation: .easeIn)
//            viewStore.send(.tabBarButtonTapped(item))
        } label: {
            content
                .pretendard(.body2)
                .foregroundStyle(
                    viewStore.selectedTab == item.tab ?
                    Color.brandColor(color: .text1) :
                    Color.brandColor(color: .text3)
                )
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .frame(maxWidth: 120)
                .edgeBorder(lineWidth: 2,
                            edges: viewStore.selectedTab == item.tab ?
                            [.bottom] : [])
        }
    }
}

//MARK: - View+

extension View {
    //MARK: - scLineTabBar
    
    /// navigation을 적용할 View에 적용합니다.
    /// - Parameters:
    ///     - items: LineTabBarItem(TabBar title)을 정의합니다.
    @ViewBuilder
    func scLineTabBar<Tab: SCLineTabProtocol>(
        store: StoreOf<SCLineTabBarFeature<Tab>>
    ) -> some View {
        self
            .padding(.top, 20)
            .overlay(alignment: .top) {
            SCLineTabBar(store: store)
                .offset(y: -20)
                .transition(.slide)
        }
    }
}

//MARK: - Preview

//#Preview {
//    Rectangle()
//        .foregroundStyle(.mint)
//        .scLineTabBar(store: .init(initialState: .init(),
//                                   reducer: { SCLineTabBarFeature() }))
//        .layout()
//}
