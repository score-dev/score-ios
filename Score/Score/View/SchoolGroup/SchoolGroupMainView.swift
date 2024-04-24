//
//  SchoolGroupMainView.swift
//  Score
//
//  Created by sole on 4/24/24.
//

import ComposableArchitecture
import SwiftUI

//MARK: - SchoolGroupMainView

struct SchoolGroupMainView: View {
    let store: StoreOf<SchoolGroupMainFeature>
    
    var body: some View {
        WithPerceptionTracking {
            Text("school group main view")
        }
    }
}

//MARK: - Preview

#Preview {
    SchoolGroupMainView(store: .init(initialState: .init(),
                                     reducer: { SchoolGroupMainFeature() } ))
}
