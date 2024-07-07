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
                  
                TypeSchoolInfoView()
                    .tag(2)
                 
                SelectGenderView()
                    .tag(3)
                    
                TypeBodyInfoView()
                    .tag(4)
                  
                SelectWorkOutTimeView()
                    .tag(5)
                
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            SCButton(style: .primary) {
                store.send(.tappedNextStepButton)
            } label: {
                Text("다음으로")
                    .frame(maxWidth: .infinity)
            }
            .layout()
        }
        .enableHideKeyBoard()
        .onAppear {
            // TabView scroll 방지
            UIScrollView.appearance().isScrollEnabled = false
        }
        .onDisappear() {
            // scroll 방지 해제
            UIScrollView.appearance().isScrollEnabled = true
        }
        
        .scNavigationBar {
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
        .scPopUp(style: .dialog,
                 isPresented: .constant(false)) {
            alertSettingPopUpBuilder()
        }
    }
    
    //MARK: - alertSettingPopUpBuilder
    
    @ViewBuilder
    func alertSettingPopUpBuilder() -> some View {
        VStack(alignment: .leading,
               spacing: 32) {
            Text(Contexts.popUpTitle.rawValue)
                .pretendard(.body1)
                .foregroundStyle(
                    Color.brandColor(color: .text1)
                )
            
            HStack(spacing: 28) {
                SCButton(style: .secondary) {
                    
                } label: {
                    Text("허용 안함")
                        .frame(maxWidth: .infinity)
                }
                
                SCButton(style: .primary) {
                    
                } label: {
                    Text("허용")
                        .frame(maxWidth: .infinity)
                }

            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
    }
    
    enum Contexts: String {
        case popUpTitle = "스코어에서\n알림을 보내도록 허용하시겠습니까?"
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
