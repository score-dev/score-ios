//
//  AttributedText.swift
//  Score
//
//  Created by sole on 7/12/24.
//

import SwiftUI

// MARK: - AttributedText

/// 여러 attribute를 적용한 Text를 연결된 하나의 Text로 반환하고 싶을 때 사용하는 구조체입니다.
/// - Parameters:
///     - textsBuilder: 연결될 Text들을 정의하는 클로저입니다.
struct AttributedText<C>: View where C: View {
    @ViewBuilder let textsBuilder: () -> C
    
    var body: some View {
        HStack(alignment: .bottom,
               spacing: 0) {
            textsBuilder()
        }
    }
}

struct Texts: View {
    let text: String
    let style: Font.Pretendard.Style?
    let size: CGFloat?
    let weight: CGFloat?
    private var color: Color = .brandColor(color: .text1)

    
    var body: some View {
        Text(text)
    }
}

// MARK: - Preview

#Preview {
    AttributedText {
        Text("123")
            .pretendard(.headline)
            .foregroundStyle(Color.blue)
        
        Text("456")
            .pretendard(.body1)
    }
}
