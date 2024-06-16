//
//  CalendarView.swift
//  Score
//
//  Created by sole on 4/12/24.
//

import ComposableArchitecture
import SwiftUI

//MARK: - CalendarView

struct CalendarView: View {
    let store: StoreOf<CalendarFeature>
    @ObservedObject var viewStore: ViewStoreOf<CalendarFeature>
    
    init(store: StoreOf<CalendarFeature>) {
        self.store = store
        self.viewStore = ViewStore(store,
                                   observe: { $0 })
    }
    
    var body: some View {
        VStack(spacing: 9) {
            // Calendar Header Section
            // year, month, buttons to control appearedMonth
            calendarHeader()
            
            // WeekOfDay Label Section
            dayOfWeekLabel()
            
            // Calendar Section
            /// frame: calendarGrid의 높이에 따라 View가 움직이는 현상을 방지합니다.
            calendarGrid()
                .frame(height: .calendarItemSize * 6)
        }
        .layout()
        .onAppear {
            store.send(.viewAppearing)
        }
    }
    
    //MARK: - calendarHeader
    
    @ViewBuilder
    func calendarHeader() -> some View {
        HStack {
            Group {
                Text(String(
                        format: "%4d",
                        viewStore.appearedYear))
                
                Text((Month(rawValue: viewStore.appearedMonth) ??
                        .october).capitalizedString())
            }
            .pretendard(weight: .black,
                        size: .m)
            
            Spacer()
            
            /// FIXME: Asset으로 변경
            Button {
                store.send(.decrementMonthButtonTapped)
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(
                        Color.brandColor(
                            color: .sub1
                        )
                    )
                    .frame(width: 34,
                           height: 34)
            }
            
            Button {
                store.send(.incrementMonthButtonTapped)
            } label: {
                Image(systemName: "chevron.right")
                    .foregroundStyle(
                        Color.brandColor(
                            color: .sub1
                        )
                    )
                    .frame(width: 34,
                           height: 34)
            }
        }
    }
    
    //MARK: - dayOfWeekLabel
    
    @ViewBuilder
    func dayOfWeekLabel() -> some View {
        HStack(spacing: 0) {
            ForEach(DayOfWeek.allCases,
                    id: \.self) { dayOfWeek in
                Text(dayOfWeek.stringValue())
                    .pretendard(.body3)
            }
            .layoutOfCalendarItem()
        }
    }
    
    //MARK: - calendarGrid
    
    @ViewBuilder
    func calendarGrid() -> some View {
        VStack(spacing: 0) {
            ForEach(viewStore.appearedDateComponentsMatrix,
                    id: \.self) { dateComponentsArray in
                HStack(spacing: 0) {
                    ForEach(dateComponentsArray,
                            id: \.self) { dateComponentsWithID in
                        CalendarGridItem(
                            store: store,
                            dateComponents: dateComponentsWithID.dateComponents
                        ) {
                            store.send(.dayComponentButtonTapped(dateComponentsWithID.dateComponents))
                        }
                    }
                }
            }
        }
    }
}

//MARK: - Preview

#Preview {
    CalendarView(store: .init(initialState: .init(),
                              reducer: { CalendarFeature() }))
}
