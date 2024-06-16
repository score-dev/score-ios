//
//  TermsAgreementFeature.swift
//  Score
//
//  Created by sole on 6/11/24.
//

import ComposableArchitecture

@Reducer
struct TermsAgreementFeature {
    struct State: Equatable {
        @BindingState var isAllTermsAgreement: Bool = false
        @BindingState var isServiceTermsAgreement: Bool = false
        @BindingState var isPrivacyTermsAgreement: Bool = false
        @BindingState var isMarketingTermsAgreement: Bool = false
        
        var isDisableButton: Bool = true
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case tappedNavigationContent(Terms)
        case checkingRequiredTermsAgreement
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding(\.$isAllTermsAgreement):
                state.isServiceTermsAgreement = state.isAllTermsAgreement
                state.isPrivacyTermsAgreement = state.isAllTermsAgreement
                state.isMarketingTermsAgreement = state.isAllTermsAgreement
                return .send(.checkingRequiredTermsAgreement)
                
            case .binding:
                // 3개 항목의 동의 상태가 같은 경우, 전체 동의도 동일하게 변경
                if state.isServiceTermsAgreement == state.isPrivacyTermsAgreement,
                   state.isPrivacyTermsAgreement == state.isMarketingTermsAgreement,
                   state.isMarketingTermsAgreement == state.isServiceTermsAgreement {
                    state.isAllTermsAgreement = state.isServiceTermsAgreement
                }
                return .send(.checkingRequiredTermsAgreement)
                
            case .tappedNavigationContent(let term):
                return .none
                
            case .checkingRequiredTermsAgreement:
                if state.isServiceTermsAgreement,
                   state.isPrivacyTermsAgreement {
                    state.isDisableButton = false
                }
                return .none
            }
        }
    }
}

enum Terms: String,
            CaseIterable {
    case all = "약관 전체동의"
    case privacy =  "(필수) 서비스 이용약관"
    case service = "(필수) 개인정보 처리 방침"
    case marketing = "(선택) 마케팅 정보 수신 동의"
}
