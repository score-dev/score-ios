//
//  TypeUserInfoMainView.swift
//  Score
//
//  Created by sole on 6/6/24.
//

import ComposableArchitecture
import SwiftUI

//MARK: - TypeUserInfoMainView

struct TypeUserInfoMainView: View {
    let store: StoreOf<TypeUserInfoFeature>
    @ObservedObject var viewStore: ViewStoreOf<TypeUserInfoFeature>
    
    init(store: StoreOf<TypeUserInfoFeature>) {
        self.store = store
        self.viewStore = .init(store,
                               observe: { $0 })
    }
    
    var body: some View {
        VStack(alignment: .leading,
               spacing: 68) {
            SCLineProgress(
                totalSteps: viewStore.totalStep,
                currentStep: viewStore.$currentStep
            )
            
            TabView(selection: viewStore.$currentStep) {
                TypeNickNameView(store: store)
                    .tag(0)
                
                SelectProfileImageView(store: store)
                    .tag(1)
                
                Text("학교")
                    .tag(2)
                
                Text("성별")
                    .tag(3)
                
                Text("키몸무게")
                    .tag(4)
                
                Text("운동 시간")
                    .tag(5)
                
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            SCButton(style: .primary) {
                store.send(.tappedNextStepButton)
            } label: {
                Text("다음으로")
                    .frame(maxWidth: .infinity)
            }
        }
        .onAppear {
            // TabView scroll 방지
            UIScrollView.appearance().isScrollEnabled = false
        }
        .onDisappear() {
            // scroll 방지 해제
            UIScrollView.appearance().isScrollEnabled = true
        }
        .layout()
        .scNavigationBar(style: .vertical) {
            DismissButton(style: .chevron) {
                store.send(.tappedDismissButton)
            }
            
            Spacer()
            
            Button {
                store.send(.tappedSkipButton)
            } label: {
                Text("건너뛰기")
                    .pretendard(weight: .bold,
                                size: .s)
                    .foregroundStyle(
                        Color.brandColor(color: .text2)
                    )
            }
        }
    }
}

//MARK: - Preview

#Preview {
    TypeUserInfoMainView(
        store: .init(
            initialState: .init(),
            reducer: { TypeUserInfoFeature() }
        )
    )
}
