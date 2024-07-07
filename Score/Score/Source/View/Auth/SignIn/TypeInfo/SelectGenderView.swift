//
//  SelectGenderView.swift
//  Score
//
//  Created by sole on 6/29/24.
//

import SwiftUI

//MARK: - SelectGenderView

struct SelectGenderView: View {
    let nickName: String = "조파랑"
    
    @State var gender: Gender?
    
    var body: some View {
        VStack(alignment: .leading,
               spacing: 32) {
            titleSectionBuilder()
            
            genderSelectSectionBuilder()
            
            Spacer()
        }
        .layout()
    }
    
    //MARK: - titleSectionBuilder
    
    @ViewBuilder
    private func titleSectionBuilder() -> some View {
        VStack(alignment: .leading,
               spacing: 4) {
            HStack(spacing: 0) {
                Text("\(nickName)")
                    .pretendard(weight: .semiBold,
                                size: .xxl)
                    .foregroundStyle(
                        Color.brandColor(color: .main)
                    )
                
                Text(Contexts.title.rawValue)
                    .pretendard(weight: .semiBold,
                                size: .xxl)
                    .foregroundStyle(
                        Color.brandColor(color: .text1)
                    )
            }
            
            Text(Contexts.guideLine.rawValue)
                .pretendard(.subHeading)
                .foregroundStyle(
                    Color.brandColor(color: .text2)
                )
        }
    }
    
    //MARK: - genderSelectSectionBuilder
    
    @ViewBuilder
    private func genderSelectSectionBuilder() -> some View {
        VStack(alignment: .leading,
               spacing: 24) {
            ForEach(Gender.allCases, id: \.self) { gender in
                SCButton(
                    style: self.gender == gender ?
                        .primary : .gray
                ) {
                    self.gender = gender
                } label: {
                    Text(gender.rawValue)
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }
    
    //MARK: - Contexts
    
    private enum Contexts: String {
        case title = "님의 성별을 알려주세요"
        case guideLine = "불편하시다면 건너뛰기를 눌러주세요!"
        
    }
}

//MARK: - Preview

#Preview {
    SelectGenderView()
}
