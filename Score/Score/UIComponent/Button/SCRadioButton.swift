//
//  SCRadioButton.swift
//  Score
//
//  Created by sole on 3/22/24.
//

import SwiftUI

//MARK: - SCRadioButton

struct SCRadioButton: View {
    @Binding var isOn: Bool
    
    var body: some View {
        Button {
            isOn.toggle()
        } label: {
            labelBuilder()
        }
    }
    
    @ViewBuilder
    func labelBuilder() -> some View {
        if isOn {
            Circle()
                .stroke()
                .frame(width: 20,
                       height: 20)
                .overlay {
                    Circle()
                        .frame(width: 10,
                               height: 10)
                }
                .foregroundStyle(Color.brandColor(color: .main))
        } else {
            Circle()
                .stroke()
                .frame(width: 20,
                       height: 20)
                .foregroundStyle(Color.brandColor(color: .gray1))
        }
    }
}

//MARK: - Preview

/// SCRadioButton의 프리뷰입니다.
#Preview {
    VStack {
        SCRadioButton(isOn: .constant(true))
        SCRadioButton(isOn: .constant(false))
    }
}
