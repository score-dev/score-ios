//
//  Color.swift
//  Score
//
//  Created by sole on 3/20/24.
//

import SwiftUI

extension Color {
    //MARK: - BrandColor
    
    // Brand Color
    enum BrandColor: UInt, CaseIterable {
        case main = 0xFF6C3E
        case subBlue = 0x19114D
        case subWhite = 0xF5F6F8
        case subRed = 0xFF4343
        case subLightBlue = 0x1975FF
        
        // 0xFF4D01
        case sub1 = 0x000000
        case sub2 = 0xFFD8CC
        case sub3 = 0xFFF0EC
    
        case gray1 = 0xC7C7C7
        case gray2 = 0xF3F4F7
        case gray3 = 0xE7E9EE
        
        case text1 = 0x2A3038
        case text2 = 0x494F58
        case text3 = 0xB2B6C2
        
        case icon = 0x6B737F
    }
    
    //MARK: - init
    
    /// hex 값으로 색을 초기화합니다.
    init(hex: UInt,
         alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
    
    //MARK: - brandColor
    
    /// brandColor 값을 Color로 반환합니다.
    static func brandColor(color: Color.BrandColor) -> Color {
        Color.init(hex: color.rawValue)
    }
}

//MARK: - Preview

/// Brand color에 등록된 모든 색상 프리뷰 
#Preview {
    ScrollView {
        VStack {
            Text("Color system")
                .pretendard(.title)
            
            ForEach(Color.BrandColor.allCases,
                    id: \.rawValue) { color in
                Text("\(color)")
                    .pretendard(.body1)
                Rectangle()
                    .foregroundStyle(Color.brandColor(color: color))
                    .frame(height: 30)
            }
        }
    }
}
