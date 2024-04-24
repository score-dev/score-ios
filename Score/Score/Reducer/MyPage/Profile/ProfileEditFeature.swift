//
//  ProfileEditFeature.swift
//  Score
//
//  Created by sole on 4/12/24.
//

import ComposableArchitecture
import PhotosUI
import SwiftUI

@Reducer
struct ProfileEditFeature {
    @Dependency(\.dismiss) var dismiss
    
    struct State: Equatable {
        var displayedUser: User?
    
        var displayedProfileImage: Image?
        
        @BindingState var displayedNickName: String
        @BindingState var displayedHeight: String
        @BindingState var displayedWeight: String
        @BindingState var displayedSex: Sex
        @BindingState var displayedSchool: String
        @BindingState var displayedGrade: Int
        
        @BindingState var isPresentingEditGradeSheet: Bool
        @BindingState var isPresentingEditSchoolSheet: Bool
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)

        case schoolEditButtonTapped
        case gradeEditButtonTapped
        case sexSelectButtonTapped(Sex)
        case editDoneButtonTapped
        case dismissButtonTapped
        
        case photoSelectChanging(PhotosPickerItem?)
        case imageUpdating(Image?)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .schoolEditButtonTapped:
                return .none
                
            case .gradeEditButtonTapped:
                // presenting sheet
                state.isPresentingEditGradeSheet = true
                return .none
                
            case .sexSelectButtonTapped(let sex):
                state.displayedSex = sex
                return .none
                
            case .editDoneButtonTapped:
                // to update the remote database
                return .none
            case .dismissButtonTapped:
                return .run { send in
                    await self.dismiss()
                }
                
            case .photoSelectChanging(let photosPickerItem):
                guard let photosPickerItem
                else {
                    return .send(.imageUpdating(nil))
                }
                
                return .run { send in
                    let image = try await photosPickerItem.loadTransferable(type: Image.self)
                    await send(.imageUpdating(image))
                } catch: { error, send in
                    await send(.imageUpdating(nil))
                }
                
            case .imageUpdating(let image):
                guard let image
                else { return .none }
                state.displayedProfileImage = image
                return .none
                
            case .binding(_):
                return .none
            }
        }
    }
}

