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
    func imageName() -> String {
        let constant = Constants.ImageName.self
        switch self {
        case .close:
            return constant.close.rawValue
        case .chevron:
            return constant.chevronLeft.rawValue
        }
    }
}

//MARK: - DismissButton

struct DismissButton: View {
    private let constant = Constants.ImageName.self
    
    let style: DismissButtonStyle
    let color: Color
    let action: () -> (Void)
    
    init(style: DismissButtonStyle,
         action: @escaping () -> (Void)) {
        self.style = style
        self.color = Color.brandColor(color: .sub1)
        self.action = action
    }
    
    init(style: DismissButtonStyle,
         color: Color,
         action: @escaping () -> (Void)) {
        self.style = style
        self.color = color
        self.action = action
    }
    
    
    var body: some View {
        Button(action: action) {
            Image(style.imageName())
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
