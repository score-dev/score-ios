//
//  CalendarGridItem.swift
//  Score
//
//  Created by sole on 4/12/24.
//

import ComposableArchitecture
import SwiftUI

//MARK: - CalendarGridItem

/// - Parameters:
///     - store: ViewStore<CalendarFeature.State, CalendarFeature.Action> CalendarView에서 받아옵니다.
///     - dateComponents: DateComponents를 정의합니다.
///     - action: 사용자가 컴포넌트를 Tap했을 때 수행할 동작을 정의합니다.
struct CalendarGridItem: View {
    let store: StoreOf<CalendarFeature>
    @ObservedObject var viewStore: ViewStoreOf<CalendarFeature>
    
    let dateComponents: DateComponents?
    let action: () -> (Void)
    
    //MARK: - style
    
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
        if viewStore.state.selectedDateComponents == dateComponents {
            return .gray
        }
        
        // 운동한 날에 .tint color
        
        return .plain
    }
    
    //MARK: - init
    
    init(store: StoreOf<CalendarFeature>,
         dateComponents: DateComponents? = nil,
         action: @escaping () -> Void) {
        self.store = store
        self.dateComponents = dateComponents
        self.action = action
        self.viewStore = ViewStore(store,
                                   observe: { $0 })
    }
    
    //MARK: - body
    
    var body: some View {
            Button(action: action) {
                SCNumberIcon(style: style,
                             number: dateComponents?.day ?? 0)
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
    CalendarGridItem(store: .init(initialState: .init(),
                                  reducer: { CalendarFeature() })) {
        
    }
}
