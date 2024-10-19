//
//  Font+.swift
//  Score
//
//  Created by sole on 3/19/24.
//

import SwiftUI

extension Font {
    //MARK: - Pretendard
    
    struct Pretendard {
        //MARK: - Weight(Pretendard)
        
        @frozen
        enum Weight: String {
            case regular = "PretendardVariable-Regular"
            case thin = "PretendardVariable-Thin"
            case extraLight = "PretendardVariable-ExtraLight"
            case light = "PretendardVariable-Light"
            case medium = "PretendardVariable-Medium"
            case semiBold = "PretendardVariable-SemiBold"
            case bold = "PretendardVariable-Bold"
            case extraBold = "PretendardVariable-ExtraBold"
            case black = "PretendardVariable-Black"
        }
        
        //MARK: - Size(Pretendard)
        
        @frozen
        enum Size: CGFloat {
            /// rawValue: 12
            case xxs = 12
            /// rawValue: 14
            case xs = 14
            /// rawValue: 16
            case s = 16
            /// rawValue: 18
            case m = 18
            /// rawValue: 20
            case l = 20
            /// rawValue: 22
            case xl = 22
            /// rawValue: 24
            case xxl = 24
            /// rawValue: 60
            case ultra = 60
            /// rawValue: 80
            case xultra = 80
        }
        
        //MARK: - Style(Pretendard)
        
        @frozen
        enum Style {
            /// regular xxl
            case headline
            /// semibold l
            case title
            /// semibold m
            case body1
            /// semibold s
            case body2
            /// semibold xs
            case body3
            /// regular s
            case subHeading
            /// medium xxs
            case caption
            /// semibold s
            case button
        }
    }
}

// MARK: - Font.Pretendard.Style+weightAndSize

extension Font.Pretendard.Style {
    //MARK: - weightAndSize
    
    /// Style에 맞는 weight와 size를 반환하는 메서드입니다.
    func weightAndSize() -> (weight: Font.Pretendard.Weight,
                             size: Font.Pretendard.Size) {
        switch self {
        case .headline:
            return (.regular, .xxl)
        case .title:
            return (.semiBold, .l)
        case .body1:
            return (.semiBold, .m)
        case .body2:
            return (.semiBold, .s)
        case .body3:
            return (.semiBold, .xs)
        case .subHeading:
            return (.regular, .s)
        case .caption:
            return (.medium, .xxs)
        case .button:
            return (.semiBold, .s)
        }
    }
}

//MARK: - View+Pretendard

extension View {
    func pretendard(_ style: Font.Pretendard.Style) -> some View {
        let fontStyle = style.weightAndSize()
        return self
            .font(.custom(fontStyle.weight.rawValue,
                          size: fontStyle.size.rawValue))
    }
    
    func pretendard(weight: Font.Pretendard.Weight,
                    size: Font.Pretendard.Size) -> some View {
        self.font(.custom(weight.rawValue,
                          size: size.rawValue))
    }
}

//MARK: - Preview

/// Typography 프리뷰
#Preview {
    VStack {
        Text("Pretendard Font Style")
            .pretendard(.title)
        Text("Headline")
            .pretendard(.headline)
        Text("Title")
            .pretendard(.title)
        Text("Body 1")
            .pretendard(.body1)
        Text("Body 2")
            .pretendard(.body2)
        Text("Body 3")
            .pretendard(.body3)
        Text("SubHeading")
            .pretendard(.subHeading)
        Text("Caption")
            .pretendard(.caption)
        Text("Button")
            .pretendard(.button)
        Text("Weight and Size")
            .pretendard(weight: .black,
                        size: .s)
    }
}
