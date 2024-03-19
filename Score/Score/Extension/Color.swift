//
//  Color.swift
//  Score
//
//  Created by sole on 3/20/24.
//

import SwiftUI

extension Color {
    // Brand Color
    enum BrandColor: UInt, CaseIterable {
        case mainColor = 0xFF4D01
        case subBlueColor = 0x19114D
        case subGrayColor = 0xC7C7C7
        case subWhiteColor = 0xF5F6F8
    }
    
    //MARK: - init
    /// hex 값으로 색을 초기화합니다.
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
    
    static func brandColor(color: Color.BrandColor) -> Color {
        Color.init(hex: color.rawValue)
    }
}


#Preview {
    VStack {
        Text("Color system")
            .pretendard(.title)
        
        ForEach(Color.BrandColor.allCases,
                id: \.rawValue) { color in
                Rectangle()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(Color.brandColor(color: color))
        }
    }
}
