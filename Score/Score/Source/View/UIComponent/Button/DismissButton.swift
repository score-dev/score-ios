//
//  DismissButton.swift
//  Score
//
//  Created by sole on 4/15/24.
//

import SwiftUI

//MARK: - DismissButtonStyle

enum DismissButtonStyle: String {
    case close
    case chevron
    
    //MARK: - imageName
    
    /// 해당하는 이미지 이름을 반환합니다.
    func imageName() -> Constants.ImageName {
        let constant = Constants.ImageName.self
        switch self {
        case .close:
            return constant.close
        case .chevron:
            return constant.chevronLeft
        }
    }
}

//MARK: - DismissButton

struct DismissButton: View {
    let style: DismissButtonStyle
    let color: Color
    let action: () -> (Void)
    
    init(style: DismissButtonStyle,
         color: Color = Color.brandColor(color: .sub1),
         action: @escaping () -> (Void)) {
        self.style = style
        self.color = color
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            style.imageName().image()
                .renderingMode(.template)
                .foregroundStyle(color)
        }
        .frame(width: 24,
               height: 24)
    }
}

//MARK: - Preview

#Preview {
    VStack {
        DismissButton(style: .chevron) {
            
        }
        
        DismissButton(style: .close,
                      color: .blue) {
            
        }
    }
}
