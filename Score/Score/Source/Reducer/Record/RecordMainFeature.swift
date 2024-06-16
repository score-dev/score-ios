//
//  RecordMainFeature.swift
//  Score
//
//  Created by sole on 4/24/24.
//

import ComposableArchitecture

@Reducer
struct RecordMainFeature {
    @Dependency(\.dismiss) var dismiss
    
    struct State: Equatable {
        
    }
    
    enum Action {
        case dismissButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .dismissButtonTapped:
                return .run { send in
                    await self.dismiss()
                }
            }
        }
    }
}
