//
//  FeedListView.swift
//  Score
//
//  Created by sole on 8/26/24.
//

import SwiftUI

struct FeedListView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(0..<100) { _ in
                    DetailFeedView()
                }
            }
        }
        .scNavigationBar {
            DismissButton(style: .chevron) {
                // store.send(.tappedDismissButton)
            }
            
            Text("피드")
        }
    }
}

#Preview {
    FeedListView()
}
