//
//  EmailGuideSheet.swift
//  Score
//
//  Created by sole on 4/24/24.
//

import ComposableArchitecture
import SwiftUI

//MARK: - EmailGuideSheet

struct EmailGuideSheet: View {
    let store: StoreOf<ContactFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    
                    DismissButton(style: .close) {
                        viewStore.send(.dismissButtonTapped)
                    }
                }
                
                Text("문의 사항을 알려주세요.")
                    .pretendard(.title)
                
                Spacer()
                
                SCButton(style: .primary) {
                    viewStore.send(.dismissButtonTapped)
                } label: {
                    Text("확인")
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.vertical, 24)
            .layout()
        }
    }
}

//MARK: - Preview

#Preview {
    EmailGuideSheet(store: .init(initialState: .init(),
                                 reducer: { ContactFeature() }))
}
