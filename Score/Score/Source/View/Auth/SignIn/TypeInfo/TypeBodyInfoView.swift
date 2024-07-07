//
//  TypeBodyInfoView.swift
//  Score
//
//  Created by sole on 6/29/24.
//

import SwiftUI

//MARK: - TypeBodyInfoView

struct TypeBodyInfoView: View {
    let nickname: String = "조파랑"
    
    var body: some View {
        VStack(alignment: .leading,
               spacing: 24) {
            titleSectionBuilder()
            
            weightAndHeightSectionBuilder()
            
            Spacer()
        }
        .layout()
    }
    
    //MARK: - titleSectionBuilder
    
    @ViewBuilder
    func titleSectionBuilder() -> some View {
        VStack(alignment: .leading,
               spacing: 4) {
            VStack(alignment: .leading,
                   spacing: 0) {
                HStack(spacing: 0) {
                    Text(nickname)
                        .foregroundStyle(
                            Color.brandColor(color: .main)
                        )
                    
                    Text(Contexts.title.rawValue)
                        .foregroundStyle(
                            Color.brandColor(color: .text1)
                        )
                    
                    Spacer()
                }
                
                Text(Contexts.continuedTitle.rawValue)
                    .foregroundStyle(
                        Color.brandColor(color: .text1)
                    )
            }
            .pretendard(weight: .semiBold,
                        size: .xxl)
            
            Text(Contexts.guideline.rawValue)
                .pretendard(.subHeading)
                .foregroundStyle(
                    Color.brandColor(color: .text2)
                )
        }
    }
    
    //MARK: - weightAndHeightSectionBuilder
    
    @ViewBuilder
    func weightAndHeightSectionBuilder() -> some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading,
                   spacing: 4) {
                Text(Contexts.height.rawValue)
                    .pretendard(weight: .regular,
                                size: .xxs)
                    .foregroundStyle(
                        Color.brandColor(color: .text2)
                    )
                
                SCTextField(style: .plain(error: nil),
                            placeHolder: "",
                            text: .constant("123"))
                .scTrailingItem {
                    Text("kg")
                        .pretendard(.subHeading)
                        .foregroundStyle(
                            Color.brandColor(color: .text3)
                        )
                }
                .keyboardType(.numberPad)
            }
            
            VStack(alignment: .leading,
                   spacing: 4) {
                Text(Contexts.weight.rawValue)
                    .pretendard(weight: .regular,
                                size: .xxs)
                    .foregroundStyle(
                        Color.brandColor(color: .text2)
                    )
                
                SCTextField(style: .plain(error: nil),
                            placeHolder: "",
                            text: .constant("123"))
                .scTrailingItem {
                    Text("kg")
                        .pretendard(.subHeading)
                        .foregroundStyle(
                            Color.brandColor(color: .text3)
                        )
                }
                .keyboardType(.numberPad)
            }
        }
    }
    
    //MARK: - Contexts
    
    private enum Contexts: String {
        case title = "님의 키와 몸무게를"
        case continuedTitle = "알려주세요"
        case guideline = "불편하시다면 건너뛰기를 눌러주세요!"
        case height = "키"
        case weight = "몸무게"
    }
}

//MARK: - TypeBodyInfoView

#Preview {
    TypeBodyInfoView()
}
