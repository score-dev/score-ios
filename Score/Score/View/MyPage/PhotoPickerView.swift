//
//  PhotoPickerView.swift
//  Score
//
//  Created by sole on 4/14/24.
//

import ComposableArchitecture
import PhotosUI
import SwiftUI

//MARK: - PhotoPickerView

struct PhotoPickerView<Content: View>: View {
    let viewStore: ViewStoreOf<ProfileEditFeature>
    
    @State var selectedPhotoItem: PhotosPickerItem?
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        PhotosPicker(selection: $selectedPhotoItem) {
            content()
        }
        /// iOS 17.0을 기점으로 분기 처리합니다.
        /// iOS 17.0 이상 : scOnChangeOver17
        /// iOS 17.0 미만 : scOnChangeUnder17 로 onChange가 적용됩니다. 
        .scOnChangeOver17(of: selectedPhotoItem) { oldValue, newValue in
            guard oldValue != newValue
            else { return }
            viewStore.send(.photoSelectChanging(newValue))
        }
        .scOnChangeUnder17(of: selectedPhotoItem) { newValue in
            viewStore.send(.photoSelectChanging(newValue))
        }
    }
}

//MARK: - View+onChange

extension View {
    //MARK: - scOnChangeOver17
    
    /// iOS 17.0 이상에서 사용할 수 있습니다.
    @ViewBuilder
    func scOnChangeOver17<V: Equatable>(
        of: V,
        _ action: @escaping (V, V) -> (Void)
    ) -> some View {
        if #available(iOS 17.0, *) {
            self.onChange(of: of, action)
        } else {
            self
        }
    }
    
    //MARK: - scOnChangeUnder17
    
    /// iOS 17.0 이상에서 사용할 수 없습니다.
    /// iOS 17.0 미만을 지원합니다.
    @ViewBuilder
    func scOnChangeUnder17<V: Equatable> (
        of: V,
        perform: @escaping (V) -> (Void)
    ) -> some View {
        if #unavailable(iOS 17.0) {
            self.onChange(of: of, perform: perform)
        } else {
            self
        }
    }
}

//MARK: - Preview

#Preview {
    PhotoPickerView(
        viewStore: .init(
            .init(
                initialState: ProfileEditFeature.State(
                    displayedNickName: "",
                    displayedHeight: "",
                    displayedWeight: "",
                    displayedSex: .female,
                    displayedSchool: "스코어대학교",
                    displayedGrade: 1,
                    isPresentingEditGradeSheet: false,
                    isPresentingEditSchoolSheet: false),
                reducer: { ProfileEditFeature() }),
            observe: { $0 }
        )
    ) {
        Text("photo picker active")
    }
}
