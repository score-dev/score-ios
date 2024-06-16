//
//  OnBoardingPage.swift
//  Score
//
//  Created by sole on 6/1/24.
//

import SwiftUI

//MARK: - OnBoardingPage

struct OnBoardingPage: View {
    private let imageNames = Constants.ImageName.OnBoarding.self
    private let contexts = Contexts.OnBoarding.self
    
    let tag: Int
    
    enum ChipTitle: String,
                    CaseIterable {
        case record = "기록하기"
        case group = "내그룹"
        case feed = "그룹피드"
        case school = "학교그룹"
        
        static subscript(index: Int) -> String {
            let allCases = Self.allCases
            
            guard index > -1
            else { return allCases[0].rawValue }
            
            guard index < allCases.count
            else { return allCases[allCases.count-1].rawValue }
            
            return allCases[index].rawValue
        }
    }
    
    var body: some View {
        VStack(spacing: 8) {
            // 상단 건너뛰기
            VStack(spacing: 20) {
                Text(ChipTitle[tag])
                    .pretendard(weight: .medium,
                                size: .xs)
                    .foregroundStyle(
                        Color.brandColor(color: .main)
                    )
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .chipViewModifier(
                        style: .capsule,
                        backgroundColor: .brandColor(color: .sub3)
                    )
                
                Text(contexts[tag])
                    .pretendard(.title)
                    .foregroundStyle(
                        Color.brandColor(color: .text1)
                    )
                    .multilineTextAlignment(.center)
            }
            
            imageNames[tag]
                .resizable()
                .frame(maxWidth: .infinity)
                .frame(maxHeight: .deviceWidth)
        }
    }
}

//MARK: - Preview

#Preview {
    OnBoardingPage(tag: 2)
}
