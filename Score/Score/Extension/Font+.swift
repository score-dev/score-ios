//
//  Font+.swift
//  Score
//
//  Created by sole on 3/19/24.
//

import SwiftUI

extension Font {
    enum Pretendard {
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
        
        enum Size: CGFloat {
            case xxs = 12
            case xs = 14
            case s = 16
            case m = 18
            case l = 20
            case xl = 22
            case xxl = 24
        }
        
        enum Style {
            case headline
            case title
            case body1
            case body2
            case body3
            case subHeading
            case caption
            case button
            
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
    }
}


extension Text {
    func pretendard(_ style: Font.Pretendard.Style) -> Text {
        let fontStyle = style.weightAndSize()
        return self.font(.custom(fontStyle.weight.rawValue,
                          size: fontStyle.size.rawValue))
    }
}

extension View {
    func pretendard(_ style: Font.Pretendard.Style) -> some View {
        let fontStyle = style.weightAndSize()
        return self
            .font(.custom(fontStyle.weight.rawValue,
                          size: fontStyle.size.rawValue))
    }
}

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
    }
}
