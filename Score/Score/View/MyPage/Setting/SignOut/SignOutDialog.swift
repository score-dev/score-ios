//
//  SignOutDialog.swift
//  Score
//
//  Created by sole on 4/21/24.
//

import ComposableArchitecture
import SwiftUI

struct SignOutDialog: View {
    let viewStore: ViewStoreOf<SettingMainFeature>
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("로그아웃하기")
                    .pretendard(.title)
                
                Spacer()
                
                DismissButton(style: .close,
                              color: .brandColor(color: .icon)) {
                    viewStore.send(.dialogDismissButtonTapped)
                }
            }
            
            Text("정말 로그아웃하시겠어요? 데이터는 그대로 남아있지만 푸시알림은 받을 수 없어요")
                .pretendard(weight: .medium,
                            size: .xs)
                .foregroundStyle(Color.brandColor(color: .text3))
            
            HStack(spacing: 28) {
                SCButton(style: .secondary) {
                    viewStore.send(.dialogDismissButtonTapped)
                } label: {
                    Text("남아있기")
                        .frame(maxWidth: .infinity)
                }
                
                SCButton(style: .primary) {
                    viewStore.send(.signOutButtonTapped)
                } label: {
                    Text("로그아웃")
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(12)
    }
}
