//
//  RecordTimerFeature.swift
//  Score
//
//  Created by sole on 8/20/24.
//

import ComposableArchitecture

@Reducer
struct RecordTimerFeature {
    @Dependency(\.continuousClock) var clock
    @Dependency(\.dismiss) var dismiss 
    
    struct State: Equatable {
        @PresentationState var destination: Destination.State?
        
        @BindingState var isRecording: Bool = false
        var minutes: Int = 0
        var seconds: Int = 0
    }
    
    enum Action: BindableAction {
        case destination(PresentationAction<Destination.Action>)
        case binding(BindingAction<State>)
        case tappedRecordToggleButton
        case timerTicking
        case startTimerTicking
        case stopTimerTicking
        case tappedMapButton
        case tappedTakePhotoButton
        case tappedRecordFinishButton
        case tappedDismissButton
    }
    
    private enum CancelID: Hashable {
        case timer
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .tappedRecordToggleButton:
                // 타이머를 시작합니다.
                if state.isRecording {
                    return .send(.startTimerTicking)
                }
                // 타이머를 종료합니다.
                return .send(.stopTimerTicking)

            case .startTimerTicking:
                return .run { [isRecording = state.isRecording] send in
                    guard isRecording else { return }
                    for await _ in clock.timer(interval: .seconds(1)) {
                        await send(.timerTicking)
                    }
                }
                .cancellable(id: CancelID.timer)
                
            case .stopTimerTicking:
                return .cancel(id: CancelID.timer)
                
            case .timerTicking:
                if state.seconds == 60 {
                    state.minutes += 1
                    state.seconds = 0
                    return .none
                }
                state.seconds += 1
                return .none
                
            case .tappedMapButton:
                state.destination = .map(.init())
                return .none
                
            case .tappedTakePhotoButton:
                state.destination = .camera(.init())
                return .none
                
            case .tappedRecordFinishButton:
                // isRecording을 false로 만들고 다음 뷰로 넘어갑니다.
                state.isRecording = false
                return .cancel(id: CancelID.timer)
                
            case .tappedDismissButton:
                return .run { _ in
                    await self.dismiss()
                }
                
            case .binding(\.$isRecording):
                return .send(.tappedRecordToggleButton)
                
            case .binding:
                return .none
                
            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination) {
            Destination()
        }
    }
    
    //MARK: - Destination
    
    @Reducer
    struct Destination {
        enum State: Equatable {
            case camera(CameraFeature.State)
            case map(MapFeature.State)
//            case feed(AddFeadFeature.State)
        }
        
        enum Action {
            case camera(CameraFeature.Action)
            case map(MapFeature.Action)
            //            case feed(AddFeadFeature.State)
        }
        
        var body: some ReducerOf<Self> {
            Scope(state: \.camera,
                  action: \.camera) {
                CameraFeature()
            }
            
            Scope(state: \.map,
                  action: \.map) {
                MapFeature()
            }
        }
    }
}
