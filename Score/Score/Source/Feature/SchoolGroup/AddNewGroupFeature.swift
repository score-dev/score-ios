//
//  AddNewGroupFeature.swift
//  Score
//
//  Created by sole on 8/24/24.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct AddNewGroupFeature {
    @Dependency(\.dismiss) var dismiss
    
    struct State: Equatable {
        var groupImage: Image?
        
        @BindingState var groupName: String = ""
        
        let maxGroupNameCount: Int = 15
        @BindingState var groupDescription: String = ""
        
        let maxGroupDescriptionCount: Int = 200
        @BindingState var groupMaxCount: Int?
        
        @BindingState var isPublicGroup: Bool = true
        @BindingState var isPrivateGroup: Bool = false
        @BindingState var privateGroupPassword: String = ""
        
        @BindingState var isPresentingMaxCountPickerSheet: Bool = false 
        
        var isDisabledGenterateButton: Bool = true
        var photoPicker: PhotoPickerFeature.State = .init()
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case tappedMaxGroupCountPickerButton
        case tappedGroupGenerateButton
        case tappedDismissButton
        case checkingEnableTappedGenerateButton
        case photoPicker(PhotoPickerFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .tappedMaxGroupCountPickerButton:
                state.isPresentingMaxCountPickerSheet = true
                return .none
                
            case .tappedDismissButton:
                return .run { _ in
                    await dismiss()
                }
                
            case .tappedGroupGenerateButton:
                return .none
                
            case .checkingEnableTappedGenerateButton:
                if !state.groupName.isEmpty,
                   state.groupMaxCount != nil,
                   (state.isPublicGroup || (state.isPrivateGroup && state.privateGroupPassword.count == 4)) {
                    state.isDisabledGenterateButton = false
                } else {
                    state.isDisabledGenterateButton = true
                }
                return .none
                
            case .photoPicker(.imageUpdating(let image)):
                state.groupImage = image
                return .none
              
            case .photoPicker:
                return .none
                
            case .binding(\.$groupName):
                if state.groupName.count > state.maxGroupNameCount {
                    state.groupName = state.groupName[0..<state.maxGroupNameCount]
                }
                return .send(.checkingEnableTappedGenerateButton)
                
            case .binding(\.$groupDescription):
                if state.groupDescription.count > state.maxGroupDescriptionCount {
                    state.groupDescription = state.groupDescription[0..<state.maxGroupDescriptionCount]
                }
                return .none
                
            case .binding(\.$groupMaxCount):
                return .send(.checkingEnableTappedGenerateButton)
                
            case .binding(\.$privateGroupPassword):
                if state.privateGroupPassword.count > 4 {
                    state.privateGroupPassword = state.privateGroupPassword[0..<4]
                }
                state.privateGroupPassword = state.privateGroupPassword.filter({ $0.isNumber })
                return .send(.checkingEnableTappedGenerateButton)
            
            case .binding(\.$isPublicGroup):
                state.isPrivateGroup = !state.isPublicGroup
                return .send(.checkingEnableTappedGenerateButton)
                
            case .binding(\.$isPrivateGroup):
                state.isPublicGroup = !state.isPrivateGroup
                return .send(.checkingEnableTappedGenerateButton)
                
            case .binding:
                return .none
            }
        }
        
        Scope(state: \.photoPicker, action: \.photoPicker) {
            PhotoPickerFeature()
        }
    }
}
