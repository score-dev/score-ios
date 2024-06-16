//
//  SCIconButton.swift
//  Score
//
//  Created by sole on 4/24/24.
//

import SwiftUI

//MARK: - SCIconButton

struct SCIconButton: View {
    private let iconSize = Constants.Layout.iconSize.rawValue
    let imageName: Constants.ImageName
    let color: Color
    let action: () -> (Void)
    
    init(imageName: Constants.ImageName,
         color: Color,
         action: @escaping () -> Void) {
        self.imageName = imageName
        self.action = action
        self.color = color
    }
    
    init(imageName: Constants.ImageName,
         action: @escaping () -> Void) {
        self.imageName = imageName
        self.action = action
        self.color = .brandColor(color: .icon)
    }
    
    var body: some View {
        Button(action: action) {
            Image(imageName.rawValue)
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(color)
                .frame(width: iconSize,
                       height: iconSize)
        }
        .frame(width: iconSize,
               height: iconSize)
    }
}

//MARK: - Preview

#Preview {
    VStack {
        SCIconButton(imageName: .arrowUp) {
            
        }
        
        SCIconButton(imageName: .arrowUp,
                     color: .brandColor(color: .main)) {
            
        }
    }
}
