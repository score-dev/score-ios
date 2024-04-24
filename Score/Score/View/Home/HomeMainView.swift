//
//  HomeMainView.swift
//  Score
//
//  Created by sole on 4/24/24.
//

import ComposableArchitecture
import SwiftUI

//MARK: - HomeMainView

struct HomeMainView: View {
    let store: StoreOf<HomeMainFeature>
    var body: some View {
        WithPerceptionTracking {
            Text("home main view")
        }
    }
}

//MARK: - Preview

#Preview {
    HomeMainView(store: .init(initialState: .init(),
                              reducer: { HomeMainFeature() }))
}
