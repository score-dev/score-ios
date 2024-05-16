//
//  SignInView.swift
//  Score
//
//  Created by sole on 5/16/24.
//

import SwiftUI

//MARK: - SignInView

struct SignInView: View {
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
                
            } label: {
                signInButtonLabelBuilder(.kakao)
            }
            
            Button {
                
            } label: {
                signInButtonLabelBuilder(.naver)
            }
            
            Button {
                
            } label: {
                signInButtonLabelBuilder(.google)
            }
            
            Button {
                
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

//MARK: - AuthCenter

enum AuthCenter: String {
    case kakao = "카카오"
    case naver = "네이버"
    case google = "구글"
    case apple = "애플"
    
    //MARK: - imageName
    
    func imageName() -> Constants.ImageName {
        switch self {
        case .kakao:
            return .kakao
        case .naver:
            return .naver
        case .google:
            return .google
        case .apple:
            return .apple
        }
    }
    
    //MARK: - backGroundColor
    
    func backGroundColor() -> Color {
        switch self {
        case .kakao:
            return .brandColor(color: .kakaoBackground)
        case .naver:
            return.white
        case .google:
            return .white
        case .apple:
            return .white
        }
    }
}

//MARK: - Preview

#Preview {
    SignInView()
}
