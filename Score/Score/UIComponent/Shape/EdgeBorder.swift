//
//  EdgeBorder.swift
//  Score
//
//  Created by sole on 3/29/24.
//

import SwiftUI

//MARK: - EdgeBorder

/// - Parameters:
///     - lineWidth: border 선의 굵기를 지정합니다.
///     - edges: border를 적용할 edge를 지정합니다.
struct EdgeBorder: Shape {
    let lineWidth: CGFloat
    let edges: [Edge]
    
    func path(in rect: CGRect) -> Path {
        edges.map { edge -> Path in
            switch edge {
            case .top:
                return Path(.init(x: rect.minX,
                                 y: rect.minY,
                                 width: rect.width,
                                 height: self.lineWidth))
            case .bottom:
                return Path(.init(x: rect.minX,
                                 y: rect.maxY,
                                 width: rect.width,
                                 height: self.lineWidth))
            case .leading:
                return Path(.init(x: rect.minX,
                                 y: rect.minY,
                                  width: self.lineWidth,
                                 height: rect.height))
            case .trailing:
                return Path(.init(x: rect.maxX,
                                 y: rect.minY,
                                 width: self.lineWidth,
                                 height: rect.height))
            }
        }.reduce(into: Path()) { partialResult, path in
            partialResult.addPath(path)
        }
    }
}

//MARK: - View+EdgeBorder

extension View {
    //MARK: - edgegBorder
    
    /// - Parameters:
    ///     - lineWidth: border 선의 굵기를 지정합니다.
    ///     - edges: border를 적용할 edge를 지정합니다.
    ///     - color: border에 적용할 색상을 지정합니다.
    @ViewBuilder
    func edgeBorder(lineWidth: CGFloat = 1,
                    edges: [Edge],
                    color: Color? = nil) -> some View {
        overlay {
                EdgeBorder(lineWidth: lineWidth,
                           edges: edges)
                .foregroundStyle(color == nil ?
                                 Color.black :
                                    color ?? .black)
            }
    }
}

//MARK: - Preview

#Preview {
    VStack {
        EdgeBorder(lineWidth: 3,
                   edges: [.top ,.bottom,
                                     .trailing, .leading])
        
        Text("123")
            .edgeBorder(edges: [.bottom, .top],
                        color: .blue)
            .foregroundStyle(Color.yellow)
    }
    .padding()
}
