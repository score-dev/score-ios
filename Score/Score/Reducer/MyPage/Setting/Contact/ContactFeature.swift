//
//  ContactFeature.swift
//  Score
//
//  Created by sole on 4/19/24.
//

import ComposableArchitecture
import MessageUI

@Reducer
struct ContactFeature {
    @Dependency(\.dismiss) var dismiss
    
    struct State: Equatable {
        var isAbleToUseMessage: Bool = false
    }
    
    enum Action {
        case viewAppearing
        case didFinishToSendMail(MFMailComposeResult)
        case dismissButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppearing:
                // 사용자의 device가 Message 사용 가능 상태인지 확인
                state.isAbleToUseMessage = MFMailComposeViewController.canSendMail()
                return .none
                
            case .dismissButtonTapped:
                return .run { send in
                    await self.dismiss()
                }
                
            case .didFinishToSendMail(_):
                return .run { send in
                    await self.dismiss()
                }
            }
        }
    }
}
