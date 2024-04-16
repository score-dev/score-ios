//
//  DismissButton.swift
//  Score
//
//  Created by sole on 4/15/24.
//

import SwiftUI

//MARK: - DismissButton

struct DismissButton: View {
    let color: Color
    let action: () -> (Void)
    
    init(action: @escaping () -> (Void)) {
        self.color = Color.brandColor(color: .sub1)
        self.action = action
    }
    
    init(color: Color,
         action: @escaping () -> (Void)) {
        self.color = color
        self.action = action
    }
    
    
    var body: some View {
        Button(action: action) {
            Image(Constants.ImageName.chevronLeft.rawValue)
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
        DismissButton {
            
        }
        
        DismissButton(color: .blue) {
            
        }
    }
}
