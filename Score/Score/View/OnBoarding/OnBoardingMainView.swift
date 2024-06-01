//
//  OnBoardingMainView.swift
//  Score
//
//  Created by sole on 6/1/24.
//

import ComposableArchitecture
import SwiftUI

//MARK: - OnBoardingMainView

struct OnBoardingMainView: View {
    let store: StoreOf<OnBoardingFeature>
    @ObservedObject var viewStore: ViewStoreOf<OnBoardingFeature>
    
    init(store: StoreOf<OnBoardingFeature>) {
        self.store = store
        self.viewStore = .init(store,
                               observe: { $0 })
    }
    
    var body: some View {
        VStack {
            TabView(selection: viewStore.$currentTag) {
                ForEach(0..<viewStore.totalIndex,
                        id: \.self) { index in
                    OnBoardingPage(tag: index)
                        .tag(index)
                }
            }
            .tabViewStyle(
                .page(indexDisplayMode: .never)
            )

            SCTabIndexIndicator(totalIndex: viewStore.totalIndex,
                                tag: viewStore.$currentTag)
            
            SCButton(style: .primary) {
                store.send(.nextButtonTapped)
            } label: {
                Text(viewStore.currentTag == viewStore.totalIndex-1 ?
                     "시작하기" : "다음으로")
                    .frame(maxWidth: .infinity)
            }
            .padding(.vertical, 20)
        }
        .layout()
        .scNavigationBar(style: .vertical) {
            Button {
                store.send(.skipButtonTapped)
            } label: {
                Text("건너뛰기")
                    .pretendard(weight: .bold,
                                size: .s)
                    .foregroundStyle(
                        Color.brandColor(color: .text1)
                    )
                    .frame(maxWidth: .infinity,
                           alignment: .trailing)
            }
        }
    }
}

//MARK: - Preview

#Preview {
    OnBoardingMainView(store: .init(initialState: .init(),
                                    reducer: { OnBoardingFeature() }))
}
