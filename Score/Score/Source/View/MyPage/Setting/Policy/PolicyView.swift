//
//  PolicyView.swift
//  Score
//
//  Created by sole on 4/21/24.
//

import ComposableArchitecture
import SwiftUI

//MARK: - PolicyView

struct PolicyView: View {
    private let navigationTitles = Navigation.Policy.self
    let store: StoreOf<PolicyFeature>
    
    // state에 접근하지 않기 때문에 ViewStore를 사용하지 않습니다. 
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                store.send(.servicePolicyButtonTapped)
            } label: {
                Text(navigationTitles.service.rawValue)
                    .settingRowModifier()
            }
            Button {
                store.send(.privacyPolicyButtonTapped)
            } label: {
                Text(navigationTitles.privacy.rawValue)
                    .settingRowModifier()
            }
            
            Spacer()
        }
        .layout()
        .scNavigationBar {
            DismissButton(style: .chevron) {
                store.send(.dismissButtonTapped)
            }
            
            Text("이용약관")
        }
        .fullScreenCover(
            store: store.scope(
                state: \.$destination.service,
                action: \.destination.service
            )
        ) { store in
            ServicePolicyView(store: store)
        }
        .fullScreenCover(
            store: store.scope(
                state: \.$destination.privacy,
                action: \.destination.privacy
            )
        ) { store in
            PrivacyPolicyView(store: store)
        }
    }
}

//MARK: - Preview

#Preview {
    PolicyView(store: .init(initialState: .init(),
                            reducer: { PolicyFeature() }))
}
