//
//  PhotoPreviewView.swift
//  Score
//
//  Created by sole on 8/2/24.
//

import SwiftUI

struct PhotoPreviewView: View {
    let image: Image
    
    var body: some View {
        VStack {
            Spacer()
            
            image
                .resizable()
                .rectFrame(size: .deviceWidth)
            
            Spacer()
            
            HStack {
                Button {
                    
                } label: {
                    Text("취소")
                        .pretendard(.button)
                        .foregroundStyle(.white)
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("저장하기")
                        .pretendard(.button)
                        .foregroundStyle(.white)
                }
            }
        }
        .layout()
        .background(.black)
    }
}

// MARK: - Preview

#Preview {
    PhotoPreviewView(image: Image(.bell))
}
