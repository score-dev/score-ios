//
//  CameraView.swift
//  Score
//
//  Created by sole on 7/12/24.
//

import ComposableArchitecture
import SwiftUI

// MARK: - CameraView

/// 기록하기 뷰 - 카메라 촬영 뷰입니다.
struct CameraView: View {
    private let store: StoreOf<CameraFeature>
    @ObservedObject var viewStore: ViewStoreOf<CameraFeature>
    
    init(store: StoreOf<CameraFeature>) {
        self.store = store
        self.viewStore = .init(store,
                               observe: { $0 })
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            CameraPreview(store: store)
                .rectFrame(size: .deviceWidth)

            Spacer()
            
            cameraButtonSection()
            
            Spacer()
        }
        .scNavigationBar(backgroundColor: .black) {
            DismissButton(style: .chevron,
                          color: .white) {
                store.send(.tappedDismissButton)
            }
            
            Text("촬영하기")
                .pretendard(.title)
                .foregroundStyle(.white)
            
            Spacer()
        }
        .background(.black)
        .onAppear {
            store.send(.viewAppearing)
        }
    }
    
    // MARK: - cameraButtonSection
    
    /// 카메라 버튼 부분 뷰입니다.
    @ViewBuilder
    private func cameraButtonSection() -> some View {
        HStack(spacing: 53) {
            PhotoPickerView(store: store.scope(state: \.photoPicker,
                                               action: \.photoPicker)) {
                SCIcon(
                    style: .init(
                        imageSize: 22,
                        circleSize: 45,
                        imageColor: .white,
                        circleColor: .init(
                            hex: 0xFFFFFF,
                            alpha: 0.25
                        )
                    ),
                    imageName: .photograph
                )
            }
            
            Button {
                store.send(.tappedCaptureButton)
            } label: {
                Circle()
                    .rectFrame(size: 69)
                    .foregroundStyle(.white)
                    .overlay {
                        Circle()
                            .stroke(
                                Color.brandColor(color: .gray1),
                                lineWidth: 2
                            )
                            .foregroundStyle(.white)
                    }
            }
            
            Button {
                store.send(.tappedFlipCameraPositionButton)
            } label: {
                SCIcon(
                    style: .init(
                        imageSize: 22,
                        circleSize: 45,
                        imageColor: .white,
                        circleColor: .init(
                            hex: 0xFFFFFF,
                            alpha: 0.25
                        )
                    ),
                    imageName: .loop
                )
            }
        }
    }
}

#Preview {
    CameraView(store: .init(initialState: .init(),
                            reducer: { CameraFeature() }))
}
