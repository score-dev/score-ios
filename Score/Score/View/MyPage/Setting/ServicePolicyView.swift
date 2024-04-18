//
//  ServicePolicyView.swift
//  Score
//
//  Created by sole on 4/16/24.
//

import SwiftUI

//MARK: - ServicePolicyView

struct ServicePolicyView: View {
    private let contexts = Contexts.Policy.self
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(contexts.service.rawValue)
            
            Spacer()
        }
        .scNavigationBar(style: .vertical) {
            Text("서비스 이용약관")
            
            Spacer()
            
            DismissButton(style: .close) {
                
            }
        }
    }
}

//MARK: - Preview

#Preview {
    ServicePolicyView()
}
