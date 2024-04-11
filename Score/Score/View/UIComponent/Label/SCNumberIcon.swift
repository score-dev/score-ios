//
//  SCNumberIcon.swift
//  Score
//
//  Created by sole on 4/1/24.
//

import SwiftUI

//MARK: - SCNumberIconStyle

enum SCNumberIconStyle: CaseIterable {
    case plain
    case tint
    case black
    case gray
    case none
}

//MARK: - SCNumberIcon

/// Calendar View 날짜를 표시하는 component입니다.
/// - Parameters:
///     - style: SCNumberIcon의 스타일을 정의합니다.
///     - number: 날짜(day)를 정의합니다.
struct SCNumberIcon: View {
    let style: SCNumberIconStyle
    let number: Int
    
    var body: some View {
        Text(String(number))
            .modifier(SCNumberIconViewModifier(style: style))
    }
}

//MARK: - SCNumberIconViewModifier

/// - Parameters:
///     - style: SCNumberIcon의 스타일을 정의합니다. 
struct SCNumberIconViewModifier: ViewModifier {
    let style: SCNumberIconStyle
    
    @ViewBuilder
    func body(content: Content) -> some View {
        switch style {
        case .plain:
            content
                .pretendard(weight: .regular,
                            size: .xs)
                .foregroundStyle(Color.black)
                .frame(width: 34, height: 34)
            
        case .tint:
            content
                .pretendard(weight: .regular,
                            size: .xs)
                .foregroundStyle(Color.brandColor(color: .main))
                .background {
                    Circle()
                        .foregroundStyle(Color.brandColor(color: .sub2))
                        .frame(width: 34, height: 34)
                }
                .frame(width: 34, height: 34)
            
        case .black:
            content
                .pretendard(weight: .regular,
                            size: .xs)
                .foregroundStyle(Color.white)
                .background {
                    Circle()
                        .foregroundStyle(Color.black)
                        .frame(width: 34, height: 34)
                }
                .frame(width: 34, height: 34)
            
        case .gray:
            content
                .pretendard(weight: .regular,
                            size: .xs)
                .foregroundStyle(Color.brandColor(color: .text1))
                .background {
                    Circle()
                        .frame(width: 34, height: 34)
                        .foregroundStyle(Color.brandColor(color: .gray2))
                }
                .frame(width: 34, height: 34)
            
        case .none:
            Rectangle()
                .frame(width: 34, height: 34)
                .foregroundStyle(Color.clear)
        }
    }
}

//MARK: - Preview

/// 모든 SCNumberIcon의 프리뷰입니다.
#Preview {
    VStack {
        Text("SCNumberIcon")
            .pretendard(.title)
        ForEach(SCNumberIconStyle.allCases,
                id: \.self) { style in
            Text("\(style)")
                .pretendard(.body1)
            SCNumberIcon(style: style,
                         number: 17)
        }
    }
}
