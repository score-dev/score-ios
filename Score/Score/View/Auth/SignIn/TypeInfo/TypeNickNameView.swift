//
//  TypeNickNameView.swift
//  Score
//
//  Created by sole on 6/6/24.
//

import ComposableArchitecture
import SwiftUI

//MARK: - TypeNickNameView

struct TypeNickNameView: View {
    let store: StoreOf<TypeUserInfoFeature>
    @ObservedObject var viewStore: ViewStoreOf<TypeUserInfoFeature>
    
    init(store: StoreOf<TypeUserInfoFeature>) {
        self.store = store
        self.viewStore = ViewStore(store,
                                   observe: { $0 })
    }
    
    var body: some View {
        VStack(alignment: .leading,
               spacing: 36) {
            
            titleSectionBuilder()
            
            textFieldSectionBuilder()
            
            Spacer()
        }
        .onTapGesture {
           hideKeyboard()
        }
    }
    
    //MARK: - titleSectionBuilder
    
    @ViewBuilder
    private func titleSectionBuilder() -> some View {
        VStack(alignment: .leading,
               spacing: 4) {
            Text(Contexts.greeting.rawValue)
                .pretendard(.subHeading)
                .foregroundStyle(
                    Color.brandColor(color: .icon)
                )
            
            Text(Contexts.title.rawValue)
                .pretendard(weight: .semiBold,
                            size: .xxl)
                .foregroundStyle(
                    Color.brandColor(color: .text1)
                )
        }
    }
    
    //MARK: - textFieldSectionBuilder
    
    @ViewBuilder
    private func textFieldSectionBuilder() -> some View {
        VStack(alignment: .leading,
               spacing: 12) {
            SCTextField(style: .plain(error: nil),
                        placeHolder: "닉네임 설정하기",
                        text: viewStore.$nickName)
            .scButtonItem {
                // event(nickNameTextFieldClearButtonTapped) send to store
            } label: {
                Image(.closeCircle)
            }
            
            Text(Contexts.nickNameConstraint.rawValue)
                .pretendard(.caption)
                .foregroundStyle(
                    Color.brandColor(color: .text2)
                )
        }
    }
    
    //MARK: - Contexts
    
    private enum Contexts: String {
        case greeting =
        """
        처음 방문하셨군요! 환영해요:)
        """
        case title =
        """
        사용할 닉네임을 입력해주세요!
        """
        case nickNameConstraint =
        """
        * 20자 이내의 한글, 영문, 숫자만 쓸 수 있어요
        """
    }
}

//MARK: - Preview

#Preview {
    TypeNickNameView(
        store: .init(initialState: .init(),
                     reducer: { TypeUserInfoFeature() })
    )
}
