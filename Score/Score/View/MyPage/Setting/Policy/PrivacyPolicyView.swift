//
//  PrivacyPolicyView.swift
//  Score
//
//  Created by sole on 4/16/24.
//

import ComposableArchitecture
import SwiftUI

//MARK: - PrivacyPolicyView.swift

struct PrivacyPolicyView: View {
    private let contexts = Contexts.Policy.self
    
    let store: StoreOf<PrivacyPolicyFeature>
    
    var body: some View {
        WithViewStore(store,
                      observe: { $0 }) { viewStore in
            ScrollView {
                VStack(alignment: .leading) {
                    Text(contexts.service.rawValue)
                    Text(contexts.privacy.rawValue)
                }
                .layout()
            }
            .scNavigationBar(style: .vertical) {
                Text("개인정보처리방침")
                
                Spacer()
                
                DismissButton(style: .close) {
                    viewStore.send(.dismissButtonTapped)
                }
            }
        }
    }
}

//MARK: - Preview

#Preview {
    PrivacyPolicyView(store: .init(initialState: .init(),
                                   reducer: { PrivacyPolicyFeature() }
                                  )
                        )
}
