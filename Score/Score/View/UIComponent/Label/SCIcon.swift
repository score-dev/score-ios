//
//  SCIcon.swift
//  Score
//
//  Created by sole on 3/31/24.
//

import SwiftUI

//MARK: - SCIconStyle

/// - Parameters:
///     - size: Icon의 크기를 정의합니다.
///     - color: Icon의 색상 스타일을 정의합니다.
struct SCIconStyle {
    let size: SCIconSize
    let color: SCIconColorStyle
    
    /// Icon의 size를 정의합니다.
    @frozen
    enum SCIconSize {
        /// circle: 20, image: 10
        case small
        /// circle: 32, image: 19
        case medium
        /// circle: 62, image: 32
        case big
    }
    
    /// Icon의 색상 스타일을 정의합니다.
    /// background 색상(Circle의 색상)을 기준으로 합니다.
    enum SCIconColorStyle {
        case main
        case sub2
        case gray3
        
        func backgrounColor() -> Color {
            switch self {
            case .main:
                return .brandColor(color: .main)
            case .sub2:
                return .brandColor(color: .sub2)
            case .gray3:
                return .brandColor(color: .gray3)
            }
        }
    }
}

//MARK: - SCIcon

struct SCIcon: View {
    let style: SCIconStyle
    let imageName: Constants.ImageName
    
    var body: some View {
        Image(imageName.rawValue)
            .resizable()
            .renderingMode(.template)
            .modifier(SCIconViewModifier(style: style))
    }
}

//MARK: - SCIconViewModifier

/// - Parameters:
///     - style: Icon의 스타일을 정의합니다.
struct SCIconViewModifier: ViewModifier {
    let style: SCIconStyle
    
    private var imageColor: Color {
        switch style.color {
        case .main:
            return .white
        case .sub2:
            return .brandColor(color: .main)
        case .gray3:
            return .brandColor(color: .icon)
        }
    }
    
    @ViewBuilder
    func body(content: Content) -> some View {
        switch style.size {
        case .small:
            content
                .frame(width: 10, height: 10)
                .foregroundStyle(self.imageColor)
                .background {
                    Circle()
                        .foregroundStyle(style.color.backgrounColor())
                        .frame(width: 20, height: 20)
                }
                .frame(width: 20, height: 20)
            
        case .medium:
            content
                .frame(width: 19, height: 19)
                .foregroundStyle(self.imageColor)
                .background {
                    Circle()
                        .foregroundStyle(style.color.backgrounColor())
                        .frame(width: 32, height: 32)
                }
                .frame(width: 32, height: 32)
            
        case .big:
            content
                .frame(width: 32, height: 32)
                .foregroundStyle(self.imageColor)
                .background {
                    Circle()
                        .foregroundStyle(style.color.backgrounColor())
                        .frame(width: 62, height: 62)
                }
                .frame(width: 62, height: 62)
        }
    }
}

//MARK: - Preview

/// 모든 SCIcon 프리뷰입니다.
#Preview {
    ScrollView {
        VStack {
            Text("SCIcon")
                .pretendard(.title)
            SCIcon(style: .init(size: .small,
                                color: .main),
                   imageName: .check)
            SCIcon(style: .init(size: .medium,
                                color: .sub2),
                   imageName: .footsteps)
            SCIcon(style: .init(size: .big,
                                color: .gray3),
                   imageName: .search)
        }
        .frame(maxWidth: .infinity)
    }
}
