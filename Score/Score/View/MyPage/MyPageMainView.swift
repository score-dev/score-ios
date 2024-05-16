//
//  MyPageMainView.swift
//  Score
//
//  Created by sole on 4/24/24.
//

import ComposableArchitecture
import SwiftUI

struct MyPageMainView: View {
    private let layoutConstants = Constants.Layout.self
    private let imageNames = Constants.ImageName.self
    let store: StoreOf<MyPageMainFeature>
    
    @State var isDisableChildScrollView: Bool = false
    
    // - FIXME: 디자인 논의 확정 후 변경
    /// ScrollView 안에 ScrollView를 넣었을 때 안쪽에 있는 ScrollView가 화면을 모두 차지하는 경우, 위쪽의 View로 넘어가지 못하는 현상 발생 
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 40) {
                    profileSectionBuilder()
                        .overlay(alignment: .bottom) {
                            buttonSectionBuilder()
                                .offset(y: 180)
                        }
                    /// 상수로 따로 빼줘야 함.
                        .padding(.bottom, 180)
                    
                        MyPageTabRouteView(store: store)
                        .frame(height: 500)
                }
            }
            .scrollIndicators(.hidden)
            .scNavigationBar(style: .vertical) {
                // - FIXME: 논의 후 반영
                DismissButton(style: .chevron) {
                    store.send(.dismissButtonTapped)
                }
                
                Text("마이페이지")
                
                Spacer()
                
                SCIconButton(imageName: .setting,
                             color: .white) {
                    // navigate to setting View
                    store.send(.settingButtonTapped)
                }
            }
            .navigationDestination(
                store: store.scope(
                    state: \.$destination.setting,
                    action: \.destination.setting
                )
            ) { store in
                SettingMainView(store: store)
            }
            .navigationDestination(
                store: store.scope(
                    state: \.$destination.profileEdit,
                    action: \.destination.profileEdit
                )
            ) { store in
                ProfileEditView(store: store)
            }
        }
    }
    
    
    //MARK: - profileSectionBuilder
    
    /// 프로필 이미지를 수정할 수 있는 부분 뷰입니다.
    @ViewBuilder
    func profileSectionBuilder() -> some View {
        HStack {
            Image("")
                .imagePlaceHolder(size: 76)
            
            VStack(alignment: .leading,
                   spacing: 12) {
                Text("닉네임")
                    .pretendard(weight: .bold,
                                size: .xxl)
                    .foregroundStyle(.white)
                
                Text("감자대학교 1학년")
                    .pretendard(.body2)
                    .foregroundStyle(.white)
            }
            
            Spacer()
        }
        .layout()
        .frame(height: 188)
        .background {
            UnevenRoundedRectangle(
                bottomLeadingRadius: 45,
                bottomTrailingRadius: 45
            )
            .foregroundStyle(Color.brandColor(color: .main))
        }
    }
    
    //MARK: - buttonSectionBuilder
    
    @ViewBuilder
    func buttonSectionBuilder() -> some View {
        VStack(alignment: .leading,
               spacing: 16) {
            SCProgressCard(image: nil,
                           level: 1000,
                           restPoint: 123,
                           progress: 0.5)
            
            HStack {
                Text("운동 알림 시간")
                    .pretendard(.body3)
                    
                Spacer()
                
                Text("매일 오전 10:00")
                    .pretendard(.body2)
            }
            .foregroundStyle(Color.brandColor(color: .text1))
            .padding(.vertical, 13)
            .padding(.horizontal, 15)
            .background(Color.brandColor(color: .gray2),
                        in: RoundedRectangle(cornerRadius: 10))
            
            HStack {
                SCButton(style: .gray) {
                    store.send(.profileEditButtonTapped)
                } label: {
                    SCLabel(style: .button,
                            imageName: .pencil,
                            title: "프로필 수정")
                    .frame(maxWidth: .infinity)
                }
                
                SCButton(style: .gray) {
                    store.send(.myFriendButtonTapped)
                } label: {
                    SCLabel(style: .button,
                            imageName: .groupUsers,
                            title: "내 친구")
                    .frame(maxWidth: .infinity)
                }

            }
            
        }
        .layout()
    }
}

//MARK: - Preview

#Preview {
    NavigationStack {
        MyPageMainView(store: .init(initialState: .init(),
                                    reducer: { MyPageMainFeature() }))
    }
}
