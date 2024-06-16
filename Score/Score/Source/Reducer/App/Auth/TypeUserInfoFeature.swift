//
//  TypeUserInfoFeature.swift
//  Score
//
//  Created by sole on 6/6/24.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct TypeUserInfoFeature {
    struct State: Equatable {
        let totalStep: Int = 6
        @BindingState var currentStep: Int = 0
        
        @BindingState var nickName: String = ""
        
        var profileImage: Image?
        var selectedScoreCharacter: Constants.ImageName.ScoreCharacter?
        
        var height: Int?
        var weight: Int?
        
        var schoolName: String = ""
        var grade: Int = 1
        
        var photoPicker: PhotoPickerFeature.State = .init()
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case tappedNextStepButton
        case tappedDismissButton
        case tappedSkipButton
        case textFieldClearButtonTapped(Self.TextField)
        case photoPicker(PhotoPickerFeature.Action)
        
        case tappedScoreImage(Constants.ImageName.ScoreCharacter)
        
        enum TextField {
            case nickName
            case schoolName
//            case grade
        }
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .tappedNextStepButton:
                // 마지막 뷰에서는 다음 뷰로 이동
                // currentStep+1
                if state.currentStep < state.totalStep-1 {
                    state.currentStep += 1
                }
                return .none
                
            case .tappedDismissButton:
                // 첫번째 뷰일 때는 navigation dismiss
                // 두번째 뷰부터는 이전 뷰로 보여주기 (currentStep-1)
                if state.currentStep > 0 {
                    state.currentStep -= 1
                }
                return .none
                
            case .tappedSkipButton:
                // 알림 허용 알럿 띄우기
                return .none
                
            case .textFieldClearButtonTapped(let field):
                switch field {
                case .nickName:
                    state.nickName = ""
                case .schoolName:
                    state.schoolName = ""
//                case .grade:
//                    break
                }
                return .none
                
            case .tappedScoreImage(let character):
                /// FIXME: 서버 프로필 이미지 저장 방식에 따라 설정 변경 필요
                state.selectedScoreCharacter = character
                // 갤러리에서 기존에 선택된 이미지를 선택 해제
                state.photoPicker.photoItem = nil
                return .none
                
            case .photoPicker(.imageUpdating(let image)):
                // 선택된 기본 이미지가 있으면 선택 해제
                state.selectedScoreCharacter = nil
                state.profileImage = image
                return .none
                
            case .photoPicker(_):
                return .none
                
            case .binding:
                return .none
            }
        }
        
        Scope(state: \.photoPicker,
              action: \.photoPicker) {
            PhotoPickerFeature()
        }
    }
}
