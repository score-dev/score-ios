//
//  SCRecordButton.swift
//  Score
//
//  Created by sole on 4/1/24.
//

import SwiftUI

//MARK: - SCRecordButton

/// - Parameters:
///     - isRecording: 기록 중이면 true, 기록이 중지되었으면 false로 할당됩니다.
struct SCRecordButton: View {
    @Binding var isRecording: Bool
    
    var body: some View {
        Button {
            isRecording.toggle()
        } label: {
            labelBuilder()
        }
    }
    
    //MARK: - labelBuilder
    
    @ViewBuilder
    func labelBuilder() -> some View {
        if isRecording {
            SCRecordTriangle(cornerRadius: 1)
                .foregroundStyle(Color.white)
                .frame(width: 21, height: 35)
                .padding(.leading, 8)
                .frame(width: 95, height: 95)
                .background(Color.black,
                            in: Circle())
            
        } else {
            HStack(spacing: 9) {
                Rectangle()
                    .frame(width: 6, height: 34)
                    .foregroundStyle(Color.white)
                
                Rectangle()
                    .frame(width: 6, height: 34)
                    .foregroundStyle(Color.white)
            }
            .frame(width: 95, height: 95)
            .background(Color.black,
                        in: Circle())
        }
    }
}

//MARK: - SCRecordTriangle

struct SCRecordTriangle: Shape {
    let cornerRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .init(x: rect.minX,
                                    y: rect.minY))
      
        _ = [CGPoint(x: rect.minX,
               y: rect.maxY),
         CGPoint(x: rect.maxX,
               y: rect.minY + rect.height / 2),
         CGPoint(x: rect.minX,
               y: rect.minY)
        ].map { point in
            path.addLine(to: point)
        }
        
        return path
    }
}

//MARK: - Preview

#Preview {
    VStack {
        SCRecordTriangle(cornerRadius: 10)
            .foregroundStyle(Color.gray)
            .padding()
        
        SCRecordButton(isRecording: .constant(true))
        SCRecordButton(isRecording: .constant(false))
    }
}
