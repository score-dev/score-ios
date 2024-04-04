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
            Image(systemName: "checkmark")
                .frame(width: 17, height: 17)
                .foregroundStyle(Color.white)
                .padding(5)
                .background(Color.brandColor(color: .main),
                            in: Circle())
        } else {
            Image(systemName: "checkmark")
                .frame(width: 17, height: 17)
                .foregroundStyle(Color.brandColor(color: .icon))
                .padding(5)
                .background(Color.brandColor(color: .gray3),
                            in: Circle())
        }
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
