//
//  SCTagChip.swift
//  Score
//
//  Created by sole on 4/3/24.
//

import SwiftUI

//MARK: - SCTagChipStyle

enum SCTagChipStyle {
    case capsule
    case roundedRectangle
    case unevenRounded
}

//MARK: - SCTagChipViewModifier

struct SCTagChipViewModifier: ViewModifier {
    let style: SCTagChipStyle
    let backgroundColor: Color
    
    @ViewBuilder
    func body(content: Content) -> some View {
        switch style {
        case .capsule:
            content
                .background(backgroundColor,
                            in: Capsule())
            
        case .roundedRectangle:
            content
                .background(backgroundColor,
                            in: RoundedRectangle(cornerRadius: 6))
            
        case .unevenRounded:
            content
                .background(backgroundColor,
                            in: .rect(
                                topLeadingRadius: 0,
                                bottomLeadingRadius: 18,
                                bottomTrailingRadius: 18,
                                topTrailingRadius: 18
                            )
                )
        }
    }
}

//MARK: - View+Chip

extension View {
    func chipViewModifier(style: SCTagChipStyle,
                          backgroundColor: Color) -> some View {
        modifier(SCTagChipViewModifier(style: style,
                                       backgroundColor: backgroundColor))
    }
}

//MARK: - Preview

#Preview {
    VStack {
        SCLabel(style: .button,
                imageName: .bell,
                title: "1234")
            .foregroundStyle(Color.red)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .chipViewModifier(style: .capsule,
                              backgroundColor: .mint)
        
        Text("1")
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .modifier(
                SCTagChipViewModifier(style: .capsule,
                          backgroundColor: .brandColor(color: .main)))
        Text("1")
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .modifier(
                SCTagChipViewModifier(style: .roundedRectangle,
                          backgroundColor: .brandColor(color: .main))
            )
    }
}
