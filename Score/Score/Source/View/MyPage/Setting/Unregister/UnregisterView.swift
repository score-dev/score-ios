//
//  UnregisterView.swift
//  Score
//
//  Created by sole on 4/16/24.
//

import ComposableArchitecture
import SwiftUI

//MARK: - UnregisterView

struct UnregisterView: View {
    private let contexts = Contexts.Unregister.self
    private let imageNames = Constants.ImageName.self
    
    let store: StoreOf<UnregisterFeature>
    @ObservedObject var viewStore: ViewStoreOf<UnregisterFeature>
    
    init(store: StoreOf<UnregisterFeature>) {
        self.store = store
        self.viewStore = ViewStore(store,
                                   observe: { $0 })
    }
    
    var body: some View {
        VStack(alignment: .leading,
               spacing: 36) {
            
            VStack(alignment: .leading,
                   spacing: 4) {
                Text(contexts.title.rawValue)
                    .pretendard(weight: .semiBold,
                                size: .xxl)
                
                Text(contexts.subTitle.rawValue)
                    .pretendard(.subHeading)
            }
            
            VStack(spacing: 20) {
                ForEach(UnregisterReason.allCases,
                        id: \.self) { reason in
                    SCButton(
                        style: viewStore.unregisterReasons.contains(reason) ?
                            .primary :
                                .gray
                    ) {
                        //select
                        viewStore.send(.reasonButtonTapped(reason))
                    } label: {
                        Text(reason.rawValue)
                            .frame(maxWidth: .infinity)
                    }
                }
                
                // FIXME: text state 적용
                SCTextField(
                    style: .plain(),
                    placeHolder: contexts.textFieldPlaceHolder.rawValue,
                    text: viewStore.$ectUnregisterReason
                )
                .scButtonItem {
                    viewStore.send(.ectReasonTextFieldClearButtonTapped)
                } label: {
                    if !viewStore.state.ectUnregisterReason.isEmpty {
                        Image(imageNames.closeCircle.rawValue)
                    }
                }
            }
            
            Spacer()
            
            SCButton(style: .primary) {
                viewStore.send(.unregisterButtonTapped)
            } label: {
                Text("탈퇴하기")
                    .frame(maxWidth: .infinity)
            }
            .buttonDisabled(viewStore.isDisableUnregisterButton)
        }
               .layout()
               .scNavigationBar {
                   DismissButton(style: .chevron) {
                       viewStore.send(.dismissButtonTapped)
                   }
                   
                   Text("탈퇴하기")
               }
               .contentShape(Rectangle())
               .onTapGesture {
                   hideKeyboard()
               }
    }
}

//MARK: - UnregisterReason

enum UnregisterReason: String,
                       CaseIterable {
    case notAsExpected = "기대했던 앱이 아니에요"
    case tooComplex = "이용이 번거롭고 불편해요"
    case tooManyErrors = "오류가 너무 많아요"
    case friendsNotUsing = "친구들이 사용을 안해요"
}

//MARK: - Preview

#Preview {
    UnregisterView(store: .init(initialState: .init(),
                                reducer: { UnregisterFeature() }))
}
