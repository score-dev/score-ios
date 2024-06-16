//
//  SignInView.swift
//  Score
//
//  Created by sole on 5/16/24.
//

import ComposableArchitecture
import SwiftUI

//MARK: - SignInView

struct SignInView: View {
    let store: StoreOf<AuthFeature>
    @ObservedObject var viewStore: ViewStoreOf<AuthFeature>
    
    init(store: StoreOf<AuthFeature>) {
        self.store = .init(initialState: .init(),
                           reducer: { AuthFeature() })
        self.viewStore = .init(store,
                               observe: { $0 })
    }
    
    var body: some View {
        VStack(spacing: 83) {
            brandSectionBuilder()
            
            signInButtonSectionBuilder()
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
        .layout()
        .background(
            Color.brandColor(color: .gray2)
        )
        .onLoading(viewStore.isLoading)
    }
    
    //MARK: - brandSectionBuilder
    
    @ViewBuilder
    private func brandSectionBuilder() -> some View {
        VStack(spacing: 16) {
            // brand logo image
            Image(Constants.ImageName.brandIcon.rawValue)
                .rectFrame(size: 169)
                .background(Color.white,
                            in: Circle())
            
            // 소개글
            VStack(spacing: 0) {
                Text("스코어와 함께라면,")
                Text("기초체력을 재밌게 키울 수 있어요!")
            }
            .pretendard(weight: .medium,
                        size: .l)
            .foregroundStyle(
                Color.brandColor(color: .text1)
            )
        }
    }
    
    //MARK: - signInButtonSectionBuilder
    
    @ViewBuilder
    private func signInButtonSectionBuilder() -> some View {
        VStack(spacing: 14) {
            Button {
                viewStore.send(.kakaoSignInButtonTapped)
            } label: {
                signInButtonLabelBuilder(.kakao)
            }
            
            Button {
                viewStore.send(.googleSingInButtonTapped)
            } label: {
                signInButtonLabelBuilder(.google)
            }
            
            Button {
                viewStore.send(.appleSignInButtonTapped)
            } label: {
                signInButtonLabelBuilder(.apple)
            }
        }
    }
    
    //MARK: - signInButtonLabelBuilder
    
    @ViewBuilder
    func signInButtonLabelBuilder(
        _ authCenter: AuthCenter
    ) -> some View {
        HStack(spacing: 10) {
            Image(authCenter.imageName().rawValue)
                .frame(width: 20,
                       height: 20)
                
            Text("\(authCenter.rawValue)로 시작하기")
                .pretendard(.button)
                .foregroundStyle(Color.black)
                .frame(maxWidth: 130)
        }
        .padding(.vertical, 18)
        .padding(.horizontal, 10)
        .frame(maxWidth: .infinity)
        .background (
            authCenter.backGroundColor(),
            in: RoundedRectangle(cornerRadius: 10)
        )
    }
}

//MARK: - Preview

#Preview {
    SignInView(store: .init(initialState: .init(),
                            reducer: { AuthFeature() }))
}
