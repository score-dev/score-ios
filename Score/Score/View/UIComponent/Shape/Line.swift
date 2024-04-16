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
    
    func path(in rect: CGRect) -> Path {
        Path(
            .init(x: rect.minX,
                  y: rect.minY,
                  width: rect.width,
                  height: lineWidth)
            )
    }
}

//MARK: - Preview

#Preview {
    Line(lineWidth: 3)
}
