//
//  SCProgressBar.swift
//  Score
//
//  Created by sole on 4/1/24.
//

import SwiftUI

//MARK: - SCProgressBar

/// - Parameters:
///     - progress: SCProgressBar의 진행도를 정의합니다. 0~1 사이의 값이어야 합니다.
struct SCProgressBar: View {
    let progress: Double
    
    /// progress의 범위를 0~1 사이의 값으로 정의합니다.
    private let progressBound: ClosedRange<Double> = 0...1
    
    /// progress를 progressBound 범위 내 값으로 변환합니다.
    private var progressInBound: Double {
        if progress < progressBound.lowerBound {
            return 0
        } else if progress > progressBound.upperBound {
            return 1
        } else {
            return progress
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 7)
                .foregroundStyle(Color.white)
                .overlay(alignment: .leading) {
                    HStack(spacing: 4) {
                        RoundedRectangle(cornerRadius: 7)
                            .foregroundStyle(Color.brandColor(color: .main))
                            .frame(width: geometry.size.width * progressInBound)
                        if progress <= 0.9 {
                            Image(Constant.ImageName.footsteps.rawValue)
                                .renderingMode(.template)
                                .foregroundStyle(Color.brandColor(color: .main))
                                .rotationEffect(.degrees(90))
                        }
                    }
                }
        }
        .frame(height: 28)
    }
}

//MARK: - Preview

/// SCProgressBar 프리뷰입니다.
#Preview {
    VStack {
        Text("SCProgressBar")
            .pretendard(.title)
        
        VStack {
            SCProgressBar(progress: -1)
            
            ForEach(stride(from: 0,
                           to: 1,
                           by: 0.1).map { $0 }, id: \.self) { progress in
                SCProgressBar(progress: progress)
            }
            
            SCProgressBar(progress: 0.94)
            
            SCProgressBar(progress: 1)
            SCProgressBar(progress: 3)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 15)
        .background(Color.black)
    }
    .padding(.horizontal, 24)
}
