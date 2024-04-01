//
//  SCLabel.swift
//  Score
//
//  Created by sole on 3/22/24.
//

import SwiftUI

//MARK: - SCLabelStyle

// FIXME: 이름 수정 예정
enum SCLabelStyle {
    case card
    case chip
    case button
}

//MARK: - SCLabel

struct SCLabel: View {
    let style: SCLabelStyle
    let imageName: String
    let title: String
    
    /// - Returns: style에 따라 SCLabel에 사용되는 이미지 크기를 반환합니다.
    private var imageSize: CGFloat {
        switch style {
        case .card:
            return 24
        case .chip:
            return 23
        case .button:
            return 20
        }
    }
    
    /// - Returns: style에 따라 SCLabel에 사용되는 폰트 스타일을 반환합니다.
    private var fontStyle: Font.Pretendard.Style {
        switch style {
        case .card:
            return .title
        case .chip:
            return .body3
        case .button:
            return .body2
        }
    }
    
    var body: some View {
        HStack(spacing: 4) {
            Image(imageName)
                .resizable()
                .renderingMode(.template)
                .frame(width: imageSize,
                       height: imageSize)
                .foregroundStyle(Color.brandColor(color: .icon))
            
            Text(title)
                .pretendard(fontStyle)
                .foregroundStyle(Color.brandColor(color: .text2))
        }
    }
}

//MARK: - Preview

/// 모든 SCLabel의 프리뷰입니다.
#Preview {
    VStack {
        SCLabel(style: .card,
                imageName: Constants.ImageName.check.rawValue,
                title: "123")
        SCLabel(style: .button,
                imageName: Constants.ImageName.camera.rawValue,
                title: "123")
        SCLabel(style: .chip,
                imageName: Constants.ImageName.dustSad.rawValue,
                title: "123")
    }
}
