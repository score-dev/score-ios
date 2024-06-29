//
//  ServicePolicyView.swift
//  Score
//
//  Created by sole on 4/16/24.
//

import ComposableArchitecture
import SwiftUI

//MARK: - ServicePolicyView

struct ServicePolicyView: View {
    private let contexts = Contexts.Policy.self
    let store: StoreOf<ServicePolicyFeature>
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(contexts.service.rawValue)
            
            Spacer()
        }
        .scNavigationBar {
            Text("서비스 이용약관")
            
            Spacer()
            
            DismissButton(style: .close) {
                store.send(.dismissButtonTapped)
            }
        }
    }
}

//MARK: - Preview

#Preview {
    ServicePolicyView(store: .init(initialState: .init(),
                                   reducer: { ServicePolicyFeature() }))
}
