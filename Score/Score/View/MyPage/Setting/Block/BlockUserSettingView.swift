//
//  BlockUserSettingView.swift
//  Score
//
//  Created by sole on 4/22/24.
//

import ComposableArchitecture
import SwiftUI

//MARK: - BlockUserSettingView

struct BlockUserSettingView: View {
    let store: StoreOf<BlockUserSettingFeature>
    
    // - FIXME: mock up data
    let users: [User] = [.defaultModel,
                         .defaultModel]
    
    var body: some View {
        WithViewStore(store,
                      observe: { $0 }) { viewStore in
            ScrollView {
                VStack(alignment: .leading,
                       spacing: 0) {
                    ForEach(users,
                            id: \.self) { user in
                        BlockUserRow(user: user)
                    }
                }
                .layout()
            }
            .scNavigationBar(style: .vertical) {
                DismissButton(style: .chevron) {
                    viewStore.send(.dismissButtonTapped)
                }
                
                Text("차단한 메이트 관리하기")
                
                Spacer()
            }
        }
    }
}

//MARK: - BlockUserRow

struct BlockUserRow: View {
    let user: User
    
    var body: some View {
        HStack(spacing: 8) {
            Image(user.profileImageName)
                .resizable()
                .frame(width: 36,
                       height: 36)
                .background {
                    Circle()
                        .foregroundStyle(
                            Color.brandColor(color: .gray2)
                        )
                }
            
            Text(user.nickName)
                .pretendard(.body2)
            
            Spacer()
            
            SCCapsuleButton(style: .gray) {
                
            } label: {
                Text("차단 해제")
            }
        }
        .padding(.vertical, 16)
    }
}

#Preview {
    BlockUserSettingView(store: .init(initialState: .init(),
                                      reducer: { BlockUserSettingFeature() }
                                        )
                                    )
}
