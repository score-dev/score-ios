//
//  Line.swift
//  Score
//
//  Created by sole on 4/16/24.
//

import SwiftUI

//MARK: - Line

struct Line: Shape {
    let lineWidth: CGFloat
    let style: Style
    
    init(lineWidth: CGFloat,
         style: Style = .horizontal) {
        self.lineWidth = lineWidth
        self.style = style
    }
    
    func path(in rect: CGRect) -> Path {
        if style == .horizontal {
            Path(
                .init(x: rect.minX,
                      y: rect.midY,
                      width: rect.width,
                      height: lineWidth)
            )
        } else {
            Path(
                .init(x: rect.midX,
                      y: rect.minY,
                      width: lineWidth,
                      height: rect.height)
            )
        }
    }
    
    enum Style {
        case vertical
        case horizontal
    }
}

//MARK: - Preview

#Preview {
    VStack {
        Line(lineWidth: 3)
            .background(Color.blue)
            .frame(height: 3)
        Line(lineWidth: 6, style: .vertical)
            .background(Color.blue)
    }
}
