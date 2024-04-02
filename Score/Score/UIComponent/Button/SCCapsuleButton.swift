//
//  SCCapsuleButton.swift
//  Score
//
//  Created by sole on 4/1/24.
//

import SwiftUI

//MARK: - SCCapsuleButtonStyle

enum SCCapsuleButtonStyle {
    case primary
    case secondary
}

//MARK: - SCCapsuleButton

struct SCCapsuleButton<Label: View>: View {
    let style: SCCapsuleButtonStyle
    let action: () -> (Void)
    @ViewBuilder let label: () -> Label
    
    var body: some View {
        Button(action: action) {
            label()
                .modifier(SCCapsuleButtonViewModifier(style: style))
        }
    }
    
    //MARK: - disable
    
    /// - Parameters:
    ///     - isDisable: true이면 대상 Button을 disable합니다.
    @ViewBuilder
    func disable(_ isDisable: Bool) -> some View {
        if isDisable {
            overlay {
                RoundedRectangle(cornerRadius: 21)
                    .foregroundStyle(Color.black)
                    .opacity(0.2)
            }
            .disabled(true)
        }
    }
}

//MARK: - SCCapsuleButtonViewModifier

struct SCCapsuleButtonViewModifier: ViewModifier {
    let style: SCCapsuleButtonStyle
    
    func body(content: Content) -> some View {
        switch style {
            
        case .primary:
            content
                .pretendard(weight: .semiBold,
                            size: .xs)
                .foregroundStyle(Color.white)
                .padding(.vertical, 12)
                .padding(.horizontal, 41)
                .background(Color.brandColor(color: .main),
                            in: RoundedRectangle(cornerRadius: 21))
        case .secondary:
            content
                .pretendard(weight: .semiBold,
                            size: .xs)
                .foregroundStyle(Color.brandColor(color: .main))
                .padding(.vertical, 12)
                .padding(.horizontal, 41)
                .background(Color.brandColor(color: .sub3),
                            in: RoundedRectangle(cornerRadius: 21))
        }
    }
}

//MARK: - Preview

/// 모든 SCCapsuleButton의 프리뷰입니다. 
#Preview {
    VStack {
        SCCapsuleButton(style: .primary) {
            
        } label: {
            Text("primary")
        }
        
        SCCapsuleButton(style: .secondary) {
            
        } label: {
            Text("secondary")
        }
        
        SCCapsuleButton(style: .secondary) {
            
        } label: {
            Text("secondary")
        }
        .disable(true)
    }
}