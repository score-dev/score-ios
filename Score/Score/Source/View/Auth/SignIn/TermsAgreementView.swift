//
//  TermsAgreementView.swift
//  Score
//
//  Created by sole on 6/11/24.
//

import ComposableArchitecture
import SwiftUI

//MARK: - TermsAgreementView

struct TermsAgreementView: View {
    let store: StoreOf<TermsAgreementFeature>
    @ObservedObject var viewStore: ViewStoreOf<TermsAgreementFeature>
    
    init(store: StoreOf<TermsAgreementFeature>) {
        self.store = store
        self.viewStore = .init(store,
                               observe: { $0 })
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            Text("서비스 이용 동의")
                .pretendard(weight: .semiBold,
                            size: .xxl)
            
            VStack(alignment: .leading,
                   spacing: 0) {
                titleBuilder()
                
                Divider()
                
                rowBuilder("(필수) 서비스 이용약관",
                           isOn: viewStore.$isServiceTermsAgreement) {
                    store.send(.tappedNavigationContent(.service))
                }
                
                rowBuilder("(필수) 개인정보 처리 방침",
                           isOn: viewStore.$isPrivacyTermsAgreement) {
                    store.send(.tappedNavigationContent(.privacy))
                }
                
                rowBuilder("(선택) 마케팅 정보 수신 동의",
                           isOn: viewStore.$isMarketingTermsAgreement) {
                    store.send(.tappedNavigationContent(.marketing))
                }
            }
            
            Spacer()
            
            SCButton(style: .primary) {
                
            } label: {
                Text("다음으로")
                    .frame(maxWidth: .infinity)
            }
            .buttonDisabled(viewStore.isDisableButton)
            .padding(.vertical, 20)
        }
        .frame(maxWidth: .infinity)
        .layout()
        .scNavigationBar {
            DismissButton(style: .chevron) {
                
            }
        }
    }
    
    //MARK: - titleBuilder
    
    @ViewBuilder
    func titleBuilder() -> some View {
        HStack(spacing: 10) {
            SCCheckBox(isOn: viewStore.$isAllTermsAgreement)
            
            Text("약관 전체동의")
                .pretendard(.body2)
            
            Spacer()
        }
        .padding(.vertical, 18)
    }
    
    //MARK: - rowBuilder
    
    @ViewBuilder
    func rowBuilder(
        _ title: String,
        isOn: Binding<Bool>,
        action: @escaping () -> (Void)
    ) -> some View {
        Button {
            action()
        } label: {
            HStack(spacing: 10) {
                SCCheckBox(isOn: isOn)
                
                Text(title)
                    .pretendard(.subHeading)
                    .foregroundStyle(
                        Color.brandColor(color: .text1)
                    )
                
                Spacer()
                
                Image(.chevronRight)
                    .renderingMode(.template)
                    .foregroundStyle(
                        Color.brandColor(color: .gray1)
                    )
            }
            .padding(.vertical, 18)
            .frame(maxWidth: .infinity)
        }
    }
}

//MARK: - Preview

#Preview {
    TermsAgreementView(
        store: .init(
            initialState: .init(),
            reducer: { TermsAgreementFeature() }
        )
    )
}
