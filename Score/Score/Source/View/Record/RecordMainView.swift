//
//  RecordMainView.swift
//  Score
//
//  Created by sole on 4/24/24.
//

import ComposableArchitecture
import SwiftUI

//MARK: - RecordMainView

struct RecordMainView: View {
    let store: StoreOf<RecordMainFeature>
    
    var body: some View {
        Text("record main view")
            .scNavigationBar {
                DismissButton(style: .chevron) {
                    store.send(.dismissButtonTapped)
                }
                
                Text("기록하기")
                
                Spacer()
            }
    }
}

//MARK: - Preview

#Preview {
    RecordMainView(store: .init(initialState: .init(),
                                reducer: { RecordMainFeature() }))
}
