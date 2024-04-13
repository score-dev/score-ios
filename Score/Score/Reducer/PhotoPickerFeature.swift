//
//  PhotoPickerFeature.swift
//  Score
//
//  Created by sole on 4/14/24.
//

import ComposableArchitecture
import PhotosUI
import SwiftUI

@Reducer
struct PhotoPickerFeature {
    struct State: Equatable {
        var selectedImage: Image?
        @BindingState var photoItem: PhotosPickerItem?
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case photoSelectChanging(PhotosPickerItem?)
        case imageUpdating(Image?)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding(_):
                return .none
            case .photoSelectChanging(let photosPickerItem):
                guard let photosPickerItem
                else {
                    return .send(.imageUpdating(nil))
                }
                return .run { send in
                    let image = try await photosPickerItem.loadTransferable(type: Image.self)
                    await send(.imageUpdating(image))
                }
            case .imageUpdating(let image):
                guard let image
                else { return .none }
                state.selectedImage = image
                return .none
            }
        }
    }
}
