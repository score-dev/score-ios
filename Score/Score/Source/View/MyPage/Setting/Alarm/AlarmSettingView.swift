//
//  AlarmSettingView.swift
//  Score
//
//  Created by sole on 4/16/24.
//

import ComposableArchitecture
import SwiftUI

//MARK: - AlarmSettingView

struct AlarmSettingView: View {
    private let navigationTitles = Navigation.Alarm.self
    
    let store: StoreOf<AlarmSettingFeature>
    @ObservedObject var viewStore: ViewStoreOf<AlarmSettingFeature>
    
    init(store: StoreOf<AlarmSettingFeature>) {
        self.store = store
        self.viewStore = ViewStore(store,
                                   observe: { $0 })
    }
    
    var body: some View {
        VStack(alignment: .leading,
               spacing: 0) {
            // 전체 알림
            Text(navigationTitles.all.rawValue)
                .alarmSettingModifier(
                    isOn: viewStore.$isActiveAllAlarmState
                )
            
            // 공지사항
            VStack(alignment: .leading,
                   spacing: 2) {
                Text(navigationTitles.notice.rawValue)
                
                Text(navigationTitles.notice.subTitle)
                    .pretendard(.caption)
                    .foregroundStyle(Color.brandColor(color: .text3))
            }
            .alarmSettingModifier(
                isOn: viewStore.$isActiveNoticeAlarm
            )
            
            // 소통
            VStack(alignment: .leading,
                   spacing: 2) {
                Text(navigationTitles.follow.rawValue)
                
                Text(navigationTitles.follow.subTitle)
                    .pretendard(.caption)
                    .foregroundStyle(Color.brandColor(color: .text3))
            }
            .alarmSettingModifier(
                isOn: viewStore.$isActiveFollowAlarm
            )
            
            // 목표 운동 시간
            VStack(alignment: .leading,
                   spacing: 2) {
                Text(navigationTitles.workOutTime.rawValue)
                
                Text(navigationTitles.workOutTime.subTitle)
                    .pretendard(.caption)
                    .pretendard(.caption)
                    .foregroundStyle(Color.brandColor(color: .text3))
            }
            .alarmSettingModifier(
                isOn: viewStore.$isActiveWorkOutTimeAlarm
            )
            
            Spacer()
        }
        .layout()
        .scNavigationBar {
            DismissButton(style: .chevron) {
                viewStore.send(.dismissButtonTapped)
            }
            
            Text("알림 설정")
        }
    }
}

//MARK: - AlarmSettingViewModifier

struct AlarmSettingViewModifier: ViewModifier {
    @Binding var isOn: Bool
    
    func body(content: Content) -> some View {
        HStack {
            content
                .pretendard(.body2)
                .foregroundStyle(
                    Color.brandColor(color: .text1)
                )
            
            Spacer()
            
            // FIXME: frame 크기 재조정 필요
            Toggle("",
                   isOn: $isOn)
            .tint(.brandColor(color: .main))
            .frame(maxWidth: 100)
        }
        .padding(.vertical, 16)
    }
}

//MARK: - View+alarmSettingModifier

extension View {
    @ViewBuilder
    func alarmSettingModifier(
        isOn: Binding<Bool>
    ) -> some View {
        modifier(AlarmSettingViewModifier(isOn: isOn))
    }
}

//MARK: - Preview

#Preview {
    AlarmSettingView(store: .init(
        initialState: .init(),
        reducer: { AlarmSettingFeature() }))
}
