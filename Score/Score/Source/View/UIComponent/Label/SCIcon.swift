//
//  SCIcon.swift
//  Score
//
//  Created by sole on 3/31/24.
//

import SwiftUI

//MARK: - SCIconStyle

struct SCIconStyle {
    let imageSize: CGFloat
    let circleSize: CGFloat
    let imageColor: Color
    let circleColor: Color
}

//MARK: - SCIcon

struct SCIcon: View {
    let style: SCIconStyle
    let imageName: Constants.ImageName
    
    var body: some View {
        Image(imageName.rawValue)
            .resizable()
            .renderingMode(.template)
            .modifier(
                SCIconViewModifier(style: style)
            )
    }
}

//MARK: - SCIconViewModifier

/// - Parameters:
///     - style: Icon의 스타일을 정의합니다.
struct SCIconViewModifier: ViewModifier {
    let style: SCIconStyle
    
    @ViewBuilder
    func body(content: Content) -> some View {
        content
            .rectFrame(size: style.imageSize)
            .foregroundStyle(style.imageColor)
            .background {
                Circle()
                    .foregroundStyle(
                        style.circleColor
                    )
                    .rectFrame(size: style.circleSize)
            }
            .rectFrame(size: style.circleSize)
    }
}

//MARK: - Preview

/// 모든 SCIcon 프리뷰입니다.
#Preview {
    ScrollView {
        VStack {
            Text("SCIcon")
                .pretendard(.title)
            SCIcon(style: 
                    .init(imageSize: 22,
                          circleSize: 45,
                          imageColor: .brandColor(color: .gray3),
                          circleColor: .brandColor(color: .gray1)),
                   imageName: .check)
        }
        .frame(maxWidth: .infinity)
    }
}
