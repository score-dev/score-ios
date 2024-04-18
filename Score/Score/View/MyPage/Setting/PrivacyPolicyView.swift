//
//  PrivacyPolicyView.swift
//  Score
//
//  Created by sole on 4/16/24.
//

import SwiftUI

//MARK: - PrivacyPolicyView.swift

struct PrivacyPolicyView: View {
    private let contexts = Contexts.Policy.self
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(contexts.service.rawValue)
                Text(contexts.privacy.rawValue)
            }
            .layout()
        }
        .scNavigationBar(style: .vertical) {
            Text("서비스 이용약관")
            
            Spacer()
            
            
            DismissButton(style: .close) {
               // dismiss this view
            }
        }
    }
}

//MARK: - Preview

#Preview {
    PrivacyPolicyView()
}
