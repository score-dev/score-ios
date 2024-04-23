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
    
    var body: some View {
        WithViewStore(store,
                      observe: { $0 }) { viewStore in
            VStack(alignment: .leading) {
                Button {
                    viewStore.send(.servicePolicyButtonTapped)
                } label: {
                    Text(navigationTitles.service.rawValue)
                        .settingRowModifier()
                }
                Button {
                    viewStore.send(.privacyPolicyButtonTapped)
                } label: {
                    Text(navigationTitles.privacy.rawValue)
                        .settingRowModifier()
                }
                
                Spacer()
            }
            .layout()
            .scNavigationBar(style: .vertical) {
                DismissButton(style: .chevron) {
                    viewStore.send(.dismissButtonTapped)
                }
                
                Text("이용약관")
            }
            .fullScreenCover(
                store: store.scope(
                state: \.$destination,
                action: \.destination
            ),
            state: /PolicyFeature.Destination.State.service,
            action: PolicyFeature.Destination.Action.service
            ) { store in
                ServicePolicyView(store: store)
            }
            .fullScreenCover(
                store: store.scope(
                state: \.$destination,
                action: \.destination
            ),
            state: /PolicyFeature.Destination.State.privacy,
            action: PolicyFeature.Destination.Action.privacy
            ) { store in
                PrivacyPolicyView(store: store)
            }
        }
    }
}

//MARK: - Preview

#Preview {
    PolicyView(store: .init(initialState: .init(),
                            reducer: { PolicyFeature() }))
}
