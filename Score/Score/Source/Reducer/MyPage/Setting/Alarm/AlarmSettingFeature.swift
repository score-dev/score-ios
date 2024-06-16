//
//  AlarmSettingFeature.swift
//  Score
//
//  Created by sole on 4/19/24.
//

import ComposableArchitecture

@Reducer
struct AlarmSettingFeature {
    @Dependency(\.dismiss) var dismiss
    
    struct State: Equatable {
        var alarm: Navigation.Alarm? = nil
        @BindingState var isActiveAllAlarmState: Bool = false
        @BindingState var isActiveFollowAlarm: Bool = false
        @BindingState var isActiveNoticeAlarm: Bool = false
        @BindingState var isActiveWorkOutTimeAlarm: Bool = false
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case viewAppearing
        case allAlarmStateEqualChecking
        case alarmStateUpdating
        case dismissButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding(\.$isActiveAllAlarmState):
                state.isActiveFollowAlarm = state.isActiveAllAlarmState
                state.isActiveNoticeAlarm = state.isActiveAllAlarmState
                state.isActiveWorkOutTimeAlarm = state.isActiveAllAlarmState
                return .send(.alarmStateUpdating)
                
            case .binding(\.$isActiveFollowAlarm):
                return .send(.allAlarmStateEqualChecking)
                
            case .binding(\.$isActiveNoticeAlarm):
                return .send(.allAlarmStateEqualChecking)
                
            case .binding(\.$isActiveWorkOutTimeAlarm):
                return .send(.allAlarmStateEqualChecking)
                
            case .binding(_):
                return .none
                
            case .viewAppearing:
                // remote data fetch 
                return .none
                
            /// 알림 설정이 모두 켜졌을 때 전체 알림 설정을 켜고 모두 꺼졌을 때는 전체 알림 설정을 끕니다.
            case .allAlarmStateEqualChecking:
                guard state.isActiveFollowAlarm == state.isActiveNoticeAlarm
                else {
                    return .send(.alarmStateUpdating)
                }
                guard state.isActiveFollowAlarm == state.isActiveWorkOutTimeAlarm
                else {
                    return .send(.alarmStateUpdating)
                }
                
                state.isActiveAllAlarmState = state.isActiveFollowAlarm
                
                return .send(.alarmStateUpdating)
                
            case .alarmStateUpdating:
                // remote Notification setting update
                return .none
                
            case .dismissButtonTapped:
                return .run { send in
                    await self.dismiss()
                }
            }
        }
    }
}
