//
//  SCTabIndexIndicator.swift
//  Score
//
//  Created by sole on 6/1/24.
//

import SwiftUI

struct SCTabIndexIndicator: View {
    let totalIndex: Int
    @Binding var tag: Int
    
    var body: some View {
        HStack {
            ForEach(0..<totalIndex,
                    id: \.self) { index in
                Button {
                    self.tag = index
                } label: {
                    Circle()
                        .rectFrame(size: 8)
                        .foregroundStyle(
                            Color.brandColor(
                                color: self.tag == index ?
                                    .main : .gray1
                            )
                        )
                }
            }
        }
    }
}

#Preview {
    SCTabIndexIndicator(totalIndex: 1,
                        tag: .constant(2))
}
