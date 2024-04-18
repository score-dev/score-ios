//
//  AlarmSettingView.swift
//  Score
//
//  Created by sole on 4/16/24.
//

import SwiftUI

//MARK: - AlarmSettingView

struct AlarmSettingView: View {
    private let navigationTitles = SettingNavigation.Alarm.self
    
    var body: some View {
        VStack(alignment: .leading,
               spacing: 0) {
            ForEach(navigationTitles.allCases,
                    id: \.self) { title in
                
                Text(title.rawValue)
                    .alarmSettingModifier(
                        isOn: .constant(false)
                    )
            }
            
            Spacer()
        }
        .layout()
        .scNavigationBar(style: .vertical) {
            DismissButton(style: .chevron) {
                
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
            
            Toggle(isOn: $isOn) {
                
            }
        }
        .padding(.vertical, 16)
    }
}

//MARK: - View+

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
    AlarmSettingView()
}
