//
//  SCButton.swift
//  Score
//
//  Created by sole on 3/21/24.
//

import SwiftUI

enum SCButtonStyle {
    case primary
    case secondary
    case teritary
    case gray
}

struct SCButton<Label : View>: View {
    let style: SCButtonStyle
    let action: () -> (Void)
    @ViewBuilder let label: () -> Label
    var body: some View {
        Button(action: action) {
            label()
                .modifier(SCButtonViewModifier(style: style))
        }
    }
}


struct SCButtonViewModifier: ViewModifier {
    let style: SCButtonStyle
    
    @ViewBuilder
    func body(content: Content) -> some View {
        switch style {
        case .primary:
            content
                .pretendard(.button)
                .foregroundStyle(Color.white)
                .padding(.horizontal, 19)
                .padding(.vertical, 19)
                .background(Color.brandColor(color: .main),
                            in: RoundedRectangle(cornerRadius: 15))
                
        case .secondary:
            content
                .pretendard(.button)
                .foregroundStyle(Color.brandColor(color: .main))
                .padding(.horizontal, 19)
                .padding(.vertical, 19)
                .background(Color.brandColor(color: .sub2),
                            in: RoundedRectangle(cornerRadius: 15))
        case .teritary:
            content
                .pretendard(.button)
                .foregroundStyle(Color.brandColor(color: .main))
                .padding(.horizontal, 19)
                .padding(.vertical, 19)
                .background(Color.brandColor(color: .gray2),
                            in: RoundedRectangle(cornerRadius: 15))
        case .gray:
            content
                .pretendard(.button)
                .foregroundStyle(Color.brandColor(color: .text2))
                .padding(.horizontal, 38)
                .padding(.vertical, 19)
                .background(Color.brandColor(color: .gray3),
                            in: RoundedRectangle(cornerRadius: 15))
        }
    }
}

#Preview {
    VStack {
        SCButton(style: .primary) {
            
        } label: {
            Text("primary")
        }
        SCButton(style: .secondary) {
            
        } label: {
            Text("secondary")
        }
        SCButton(style: .teritary) {
            
        } label: {
            Text("teritary")
        }
        
        SCButton(style: .gray) {
            
        } label: {
            Text("gray")
        }
    }
}
