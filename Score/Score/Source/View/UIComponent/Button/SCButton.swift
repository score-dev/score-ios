//
//  SCButton.swift
//  Score
//
//  Created by sole on 3/21/24.
//

import SwiftUI

//MARK: - SCButtonStyle

enum SCButtonStyle {
    case primary
    case secondary
    case teritary
    case gray
    case black
}

//MARK: - SCButton

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
    
    //MARK: - buttonDisabled
    
    /// SCButton을 disable합니다.
    /// - Parameters:
    ///     - isDisabled: true일 때 Button이 disable됩니다. 
    @ViewBuilder
    func buttonDisabled(
        _ isDisabled: Bool
    ) -> some View {
        if isDisabled {
            self
                .disabled(isDisabled)
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(Color.white)
                        .opacity(0.7)
                }
        } else { 
            self
        }
    }
}


//MARK: - SCButtonViewModifier

/// SCButtonStyle에 따라 View를 꾸밉니다.
struct SCButtonViewModifier: ViewModifier {
    let style: SCButtonStyle
    
    @ViewBuilder
    func body(content: Content) -> some View {
        switch style {
        case .primary:
            content
                .pretendard(.button)
                .foregroundStyle(Color.white)
                .padding(.vertical, 19)
                .padding(.horizontal, 19)
                .background(Color.brandColor(color: .main),
                            in: RoundedRectangle(cornerRadius: 15))
                
        case .secondary:
            content
                .pretendard(.button)
                .foregroundStyle(Color.brandColor(color: .main))
                .padding(.vertical, 19)
                .padding(.horizontal, 19)
                .background(Color.brandColor(color: .sub3),
                            in: RoundedRectangle(cornerRadius: 15))
        case .teritary:
            content
                .pretendard(.button)
                .foregroundStyle(Color.brandColor(color: .main))
                .padding(.vertical, 19)
                .padding(.horizontal, 19)
                .background(Color.brandColor(color: .gray2),
                            in: RoundedRectangle(cornerRadius: 15))
        case .gray:
            content
                .pretendard(.button)
                .foregroundStyle(Color.brandColor(color: .text2))
                .padding(.vertical, 19)
                .padding(.horizontal, 38)
                .background(Color.brandColor(color: .gray2),
                            in: RoundedRectangle(cornerRadius: 15))
        case .black:
            content
                .pretendard(weight: .medium,
                            size: .xs)
                .foregroundStyle(Color.white)
                .padding(.vertical, 12)
                .padding(.horizontal, 24)
                .background(Color.black,
                            in: RoundedRectangle(cornerRadius: 15))
        }
    }
}

//MARK: - Preview

/// 모든 Button Style 프리뷰입니다.
#Preview {
    VStack {
        SCButton(style: .primary) {
            
        } label: {
            Text("primary")
        }
        
        SCButton(style: .primary) {
            
        } label: {
            Text("primary")
        }
        .buttonDisabled(true)
        
        SCButton(style: .secondary) {
            
        } label: {
            Text("secondary")
        }
        
        SCButton(style: .secondary) {
            
        } label: {
            Text("secondary")
        }
        .buttonDisabled(false)
        
        SCButton(style: .teritary) {
            
        } label: {
            Text("teritary")
        }
        
        SCButton(style: .gray) {
            
        } label: {
            Text("gray")
        }
        
        SCButton(style: .black) {
            
        } label: {
            Text("black")
        }
    }
}
