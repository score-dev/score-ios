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
        var photoPicker: PhotoPickerFeature.State = .init()
        
        // - FIXME: User profile State -> User로 통합할지 서버 데이터 확인 후 결정
        
        @BindingState var displayedNickName: String = ""
        @BindingState var displayedHeight: String = ""
        @BindingState var displayedWeight: String = ""
        @BindingState var displayedSex: Gender = .etc
        @BindingState var displayedSchool: String = ""
        @BindingState var displayedGrade: Int = 0
        
        // isPresented Sheet State
        @BindingState var isPresentingEditWorkOutTime: Bool = false
        @BindingState var isPresentingEditGradeSheet: Bool = false
        @BindingState var isPresentingEditSchoolSheet: Bool = false
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)

        case workOutTimeButtonTapped
        case schoolEditButtonTapped
        case gradeEditButtonTapped
        case sexSelectButtonTapped(Gender)
        case editDoneButtonTapped
        case dismissButtonTapped
        
        case photoPicker(PhotoPickerFeature.Action)
        case imageUpdating(Image?)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .workOutTimeButtonTapped:
                state.isPresentingEditWorkOutTime = true
                return .none
                
            case .schoolEditButtonTapped:
                state.isPresentingEditSchoolSheet = true
                return .none
                
            case .gradeEditButtonTapped:
                state.isPresentingEditGradeSheet = true
                return .none
                
            case .sexSelectButtonTapped(let sex):
                // - FIXME: 둘 다 선택하지 않을 경우 기타로 할당합니다. (기획 확정 필요)
                if state.displayedSex == sex {
                    state.displayedSex = .etc
                } else {
                    state.displayedSex = sex
                }
                return .none
        
            case .imageUpdating(let image):
                guard let image
                else { return .none }
                state.displayedProfileImage = image
                return .none
                
            case .photoPicker(.imageUpdating(let image)):
                return .send(.imageUpdating(image))
                
            case .editDoneButtonTapped:
                // to update the remote database
                return .none
                
            case .dismissButtonTapped:
                return .run { send in
                    await self.dismiss()
                }
                
            case .binding,
                    .photoPicker:
                return .none
            }
        }
        
        //MARK: - Scope
        
        Scope(state: \.photoPicker,
              action: \.photoPicker) {
            PhotoPickerFeature()
        }
    }
}

