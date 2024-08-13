//
//  CameraFeature.swift
//  Score
//
//  Created by sole on 7/13/24.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct CameraFeature {
    
    struct State: Equatable {
        let camera: Camera = .init()
        let photoPicker: PhotoPickerFeature.State = .init()
    }
    
    enum Action {
        case viewAppearing
        case tappedDismissButton
        case cameraStarting
        case cameraStopping
        case tappedCaptureButton
        case tappedFlipCameraPositionButton
        case tappedGallaryButton
        case capturedImage(data: Data)
        case photoPicker(PhotoPickerFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppearing:
                return .run { send in
                    await Camera.requestAuthorization()
                    await send(.cameraStarting)
                }
                
            case .tappedDismissButton:
                return .none
                
            case .cameraStarting:
                state.camera.start()
                return .none
                
            case .cameraStopping:
                state.camera.stop()
                return .none
                
            case .tappedCaptureButton:
                state.camera.capture()
                return .none
                
            case .tappedFlipCameraPositionButton:
                state.camera.flipPosition()
                return .none
                
            case .tappedGallaryButton:
                return .none
                
            case .photoPicker(_):
                return .none 
                
            case .capturedImage(let data):
                return .run { send in
                    try await PhotoLibrary.shared.saveImage(imageData: data)
                    // preview 보여주기? 아님 그냥 저장
                }
            }
        }
    }
}

