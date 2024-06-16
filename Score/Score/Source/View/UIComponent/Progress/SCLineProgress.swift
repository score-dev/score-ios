//
//  SCLineProgress.swift
//  Score
//
//  Created by sole on 4/16/24.
//

import SwiftUI

//MARK: - SCLineProgress
/// - Parameters:
///     - totalSteps: 수행해야 하는 총 단계를 정의합니다.
///     - currentStep: 현재 단계를 정의합니다. (0 ~ totalSteps-1) 사이 값으로 정의합니다.
struct SCLineProgress: View {
    let totalSteps: Int
    @Binding var currentStep: Int
    
    private let lineWidth: CGFloat = 3
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<totalSteps,
                    id: \.self) { step in
                Line(lineWidth: lineWidth)
                    .clipShape(Capsule())
                    .foregroundStyle(
                        currentStep >= step ?
                        Color.brandColor(color: .main) :
                        Color.brandColor(color: .gray2)
                    )
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: lineWidth)
    }
}

//MARK: - Preview

#Preview {
    SCLineProgress(totalSteps: 5,
                   currentStep: .constant(2))
        .layout()
}
