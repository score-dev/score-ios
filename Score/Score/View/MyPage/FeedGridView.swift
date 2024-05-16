//
//  FeedGridView.swift
//  Score
//
//  Created by sole on 4/25/24.
//

import ComposableArchitecture
import SwiftUI

struct FeedGridView: View {
    private let columnLayout: [GridItem] = [
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible())
    ]
    
    let store: StoreOf<FeedMainFeature>
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columnLayout,
                      spacing: 2) {
                // - FIXME: Mock up view
                ForEach(0..<299) { num in
                    Image(systemName: "photo.fill.on.rectangle.fill")
                        .foregroundStyle(.black)
                        .rectFrame(size: .deviceWidth / 3)
                        .background(
                            Color.brandColor(color: .gray2)
                        )
                }
            }
        }
    }
}

#Preview {
    FeedGridView(store: .init(initialState: .init(),
                              reducer: { FeedMainFeature() }))
}
