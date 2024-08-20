//
//  TimerRecordView.swift
//  Score
//
//  Created by sole on 8/20/24.
//

import ComposableArchitecture
import SwiftUI

struct TimerRecordView: View {
    private let store: StoreOf<RecordTimerFeature>
    @ObservedObject var viewStore: ViewStoreOf<RecordTimerFeature>
    
    init(store: StoreOf<RecordTimerFeature>) {
        self.store = store
        self.viewStore = .init(store,
                               observe: { $0 })
    }
    var body: some View {
        VStack {
            timerSectionBuilder()
            
            buttonSectionBuilder()
                .padding(.bottom, 20)
        }
        .background(
            Color.brandColor(color: .trackRed)
        )
        .scNavigationBar {
            DismissButton(style: .chevron) {
                store.send(.tappedDismissButton)
            }
            
            Text("기록하기")
            
            Spacer()
        }
        .navigationDestination(
            store: store.scope(
                state: \.$destination.camera,
                action: \.destination.camera
            )
        ) { store in
            CameraView(store: store)
        }
        .navigationDestination(
            store: store.scope(
                state: \.$destination.map,
                action: \.destination.map
            )
        ) { store in
            MapView(store: store)
        }
    }
    
    @ViewBuilder
    private func timerSectionBuilder() -> some View {
        Image(.track)
            .resizable()
            .frame(width: .deviceWidth)
            .frame(maxHeight: .infinity)
            .overlay {
                VStack(spacing: 22) {
                    // FIXME: Text 위치 고정 더 나은 방법 찾아보기 
                    HStack {
                        Text(String(format: "%02d", viewStore.minutes))
                            .frame(maxWidth: .deviceWidth / 3, alignment: .trailing)
                        
                        Text(":")
                            .frame(maxWidth: 20)
                        
                        Text(String(format: "%02d", viewStore.seconds))
                            .frame(maxWidth: .deviceWidth / 3, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity)
                    .pretendard(weight: .bold,
                                size: .xultra)
                    .foregroundStyle(
                        Color.brandColor(color: .text1)
                    )
                
                    SCRecordButton(isRecording: viewStore.$isRecording)
                }
            }
    }
    
    @ViewBuilder
    private func buttonSectionBuilder() -> some View {
        // buttons section
        VStack(spacing: 12) {
            HStack(spacing: 10) {
                SCButton(style: .gray) {
                    store.send(.tappedTakePhotoButton)
                } label: {
                    HStack(spacing: 4) {
                        Image(.camera)
                            .resizable()
                            .rectFrame(size: 21)
                        
                        Text("인증샷 촬영")
                            .foregroundStyle(
                                Color.brandColor(color: .text2)
                            )
                            .frame(maxWidth: .infinity)
                    }
                }
                
                SCButton(style: .gray) {
                    store.send(.tappedMapButton)
                } label: {
                    HStack(spacing: 4) {
                        Image(.mapMarker)
                            .resizable()
                            .rectFrame(size: 20)
                        
                        Text("지도 보기")
                            .foregroundStyle(
                                Color.brandColor(color: .text2)
                            )
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            
            SCButton(style: .primary) {
                // navigate to
                store.send(.tappedRecordFinishButton)
            } label: {
                Text("기록 종료")
                    .frame(maxWidth: .infinity)
            }
        }
        .layout()
    }
}


#Preview {
    TimerRecordView(store: .init(initialState: .init(),
                                 reducer: { RecordTimerFeature() }))
}
