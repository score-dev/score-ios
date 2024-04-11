//
//  CalendarGridItem.swift
//  Score
//
//  Created by sole on 4/12/24.
//

import ComposableArchitecture
import SwiftUI

//MARK: - CalendarGridItem

// - FIXME: CalendarView에서 무조건 store를 받아와야 하는데, 효율적인지?
/// - Parameters:
///     - store: ViewStore<CalendarFeature.State, CalendarFeature.Action> CalendarView에서 받아옵니다.
///     - dateComponents: DateComponents를 정의합니다.
///     - action: 사용자가 컴포넌트를 Tap했을 때 수행할 동작을 정의합니다.
struct CalendarGridItem: View {
    let store: ViewStore<CalendarFeature.State,
                         CalendarFeature.Action>
    let dateComponents: DateComponents?
    let action: () -> (Void)
    
    private var style: SCNumberIconStyle {
        guard let dateComponents
        else {
            return .none
        }
        let nowDate = Date.nowDate()
        
        if nowDate.year == dateComponents.year,
           nowDate.month == dateComponents.month,
           nowDate.day == dateComponents.day {
            return .black
        }
        
        // - FIXME: 오늘 날짜가 black인지? 디자인 확인 필요
        if store.state.selectedDateComponents == dateComponents {
            return .gray
        }
        
        // 운동한 날에 .tint color
        
        return .plain
    }
    
    var body: some View {
            Button(action: action) {
                SCNumberIcon(style: style,
                             number: dateComponents?.day
                             ?? 0)
                /// 양쪽 layout padding 효과
                .layoutOfCalendarItem()
                .background {
                    if style == .none {
                        Color.brandColor(color: .gray2)
                    }
                }
                .edgeBorder(edges: [.top,
                                    .bottom,
                                    .leading,
                                    .trailing],
                            color: Color.brandColor(
                                color: .gray3)
                            )
            }
            .disabled(style == .none)
    }
}

//MARK: - Preview

#Preview {
    CalendarGridItem(store: .init(.init(initialState: CalendarFeature.State(appearedYear: 0, appearedMonth: 0, appearedDay: 0, appearedDateComponentsMatrix: []), reducer: {CalendarFeature().body}), observe: {$0}), dateComponents: nil) {
        
    }
}
