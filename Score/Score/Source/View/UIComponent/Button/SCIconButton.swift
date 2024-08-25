//
//  SCIconButton.swift
//  Score
//
//  Created by sole on 4/24/24.
//

import SwiftUI

//MARK: - SCIconButton

struct SCIconButton: View {
    let imageName: Constants.ImageName
    let color: Color
    private let size: CGFloat
    let action: () -> (Void)
    
    init(imageName: Constants.ImageName,
         color: Color = .brandColor(color: .icon),
         size: CGFloat = Constants.Layout.iconSize.rawValue,
         action: @escaping () -> Void) {
        self.imageName = imageName
        self.color = color
        self.size = size
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Image(imageName.rawValue)
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(color)
                .rectFrame(size: size)
        }
        .rectFrame(size: size)
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
