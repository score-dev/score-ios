//
//  SCLabel.swift
//  Score
//
//  Created by sole on 3/22/24.
//

import SwiftUI

// FIXME: 이름 수정 예정
enum SCLabelStyle {
    case banner
    case chip
    case button
}

struct SCLabel: View {
    let style: SCLabelStyle
    let imageName: String
    let title: String
    
    private var imageSize: CGFloat {
        switch style {
        case .banner:
            return 24
        case .chip:
            return 23
        case .button:
            return 20
        }
    }
    
    private var fontStyle: Font.Pretendard.Style {
        switch style {
        case .banner:
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
                .frame(width: imageSize,
                       height: imageSize)
                .foregroundStyle(Color.brandColor(color: .iconColor))
            
            Text(title)
                .pretendard(fontStyle)
                .foregroundStyle(Color.brandColor(color: .textColor2))
        }
    }
}

#Preview {
    VStack {
        SCLabel(style: .banner,
                imageName: "",
                title: "123")
        SCLabel(style: .button,
                imageName: "",
                title: "123")
        SCLabel(style: .chip,
                imageName: "",
                title: "123")
    }
}
