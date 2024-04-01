//
//  SCIcon.swift
//  Score
//
//  Created by sole on 3/31/24.
//

import SwiftUI

//MARK: - SCIconStyle

enum SCIconStyle: String,
                  CaseIterable {
    case tintHeart
    case heart
    case footsteps
    case check
    case reverseCheck
    case bigCheck
    case flag
    
    case reactionHeart
    case reactionFire
    case reacitonStar
    case reactionConfetti
    
    /// - Returns: SCIcon에 쓰이는 이미지 이름을 반환합니다.
    func imageName() -> String {
        switch self {
        case .tintHeart,
                .heart:
            return Constants.ImageName.heart.rawValue
        case .footsteps:
            return Constants.ImageName.footsteps.rawValue
        case .check,
                .reverseCheck,
                .bigCheck:
            return Constants.ImageName.check.rawValue
        case .flag:
            return Constants.ImageName.flag.rawValue
        case .reactionHeart:
            return Constants.ImageName.reactionHeart.rawValue
        case .reactionFire:
            return Constants.ImageName.reactionFire.rawValue
        case .reacitonStar:
            return Constants.ImageName.reactionStar.rawValue
        case .reactionConfetti:
            return Constants.ImageName.reactionConfetti.rawValue
        }
    }
}

//MARK: - SCIcon

struct SCIcon: View {
    let style: SCIconStyle
    
    var body: some View {
        Image(style.imageName())
            .resizable()
            .renderingMode(.template)
            .modifier(SCIconViewModifier(style: style))
    }
}

//MARK: - SCIconViewModifier

struct SCIconViewModifier: ViewModifier {
    let style: SCIconStyle
    
    @ViewBuilder
    func body(content: Content) -> some View {
        switch style {
        case .tintHeart:
            content
                .foregroundStyle(Color.white)
                .frame(width: 15, height: 15)
                .background {
                    Circle()
                        .foregroundStyle(Color.brandColor(color: .main))
                        .frame(width: 32, height: 32)
                }
                .frame(width: 32, height: 32)
            
        case .heart:
            content
                .foregroundStyle(Color.brandColor(color: .icon))
                .frame(width: 15, height: 15)
                .background {
                    Circle()
                        .foregroundStyle(Color.brandColor(color: .gray3))
                        .frame(width: 32, height: 32)
                }
                .frame(width: 32, height: 32)
            
        case .footsteps:
            content
                .foregroundStyle(Color.brandColor(color: .icon))
                .frame(width: 19, height: 19)
                .background {
                    Circle()
                        .foregroundStyle(Color.brandColor(color: .gray3))
                        .frame(width: 32, height: 32)
                }
                .frame(width: 32, height: 32)
            
        case .check:
            content
                .foregroundStyle(Color.white)
                .frame(width: 19, height: 19)
                .background {
                    Circle()
                        .foregroundStyle(Color.brandColor(color: .main))
                        .frame(width: 32, height: 32)
                }
                .frame(width: 32, height: 32)
            
        case .reverseCheck:
            content
                .foregroundStyle(Color.brandColor(color: .main))
                .frame(width: 19, height: 19)
                .background {
                    Circle()
                        .foregroundStyle(Color.brandColor(color: .sub2))
                        .frame(width: 32, height: 32)
                }
                .frame(width: 32, height: 32)
            
        case .bigCheck:
            content
                .foregroundStyle(Color.white)
                .frame(width: 36, height: 36)
                .background {
                    Circle()
                        .foregroundStyle(Color.brandColor(color: .main))
                        .frame(width: 62, height: 62)
                }
                .frame(width: 62, height: 62)
        case .flag:
            content
                .foregroundStyle(Color.white)
                .frame(width: 10, height: 10)
                .background {
                    Circle()
                        .foregroundStyle(Color.brandColor(color: .main))
                        .frame(width: 20, height: 20)
                }
                .frame(width: 20, height: 20)
            
        case .reactionHeart,
                .reactionFire,
                .reacitonStar:
            content
                .foregroundStyle(Color.brandColor(color: .icon))
                .frame(width: 18, height: 18)
                .background {
                    Circle()
                        .foregroundStyle(Color.brandColor(color: .gray2))
                        .frame(width: 32, height: 32)
                }
                .frame(width: 32, height: 32)
        
        case .reactionConfetti:
            content
                .foregroundStyle(Color.brandColor(color: .icon))
                .frame(width: 20, height: 20)
                .background {
                    Circle()
                        .foregroundStyle(Color.brandColor(color: .gray2))
                        .frame(width: 32, height: 32)
                }
                .frame(width: 32, height: 32)
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
            ForEach(SCIconStyle.allCases,
                    id: \.self) { style in
                Text("\(style)")
                    .pretendard(.body1)
                SCIcon(style: style)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
