//
//  SCCheckBox.swift
//  Score
//
//  Created by sole on 3/21/24.
//

import SwiftUI

//MARK: - SCCheckBox

struct SCCheckBox: View {
    @Binding var isOn: Bool
    let activeColor: Color
    let checkColor: Color
    
    init(
        isOn: Binding<Bool>,
        activeColor: Color = .brandColor(color: .main),
        checkColor: Color = Color.brandColor(color: .icon)
    ) {
        self._isOn = isOn
        self.activeColor = activeColor
        self.checkColor = checkColor
    }
    
    var body: some View {
        Button {
            isOn.toggle()
        } label: {
            labelBuilder()
        }
    }
    
    //MARK: - labelBuilder
    
    @ViewBuilder
    func labelBuilder() -> some View {
        Image(.check)
            .resizable()
            .frame(width: 15, height: 15)
            .foregroundStyle(
                isOn ?
                Color.white : activeColor
            )
            .padding(2)
            .background(
                isOn ?
                activeColor :
                Color.brandColor(color: .gray3),
                in: Circle()
            )
    }
}

//MARK: - Preview

/// SCCheckBox의 프리뷰입니다.
#Preview {
    VStack {
        SCCheckBox(isOn: .constant(true))
        SCCheckBox(isOn: .constant(false))
    }
}
