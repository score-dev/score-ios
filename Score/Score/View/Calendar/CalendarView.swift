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
    
    var body: some View {
        WithViewStore(store,
                      observe: { $0 }) { viewStore in
            VStack(spacing: 9) {
                // Calendar Header Section
                // year, month, buttons to control appearedMonth
                calendarHeader(viewStore: viewStore)
                
                // WeekOfDay Label Section
                dayOfWeekLabel(viewStore: viewStore)
                
                // Calendar Section
                calendarGrid(viewStore: viewStore)
            }
            .layout()
            .onAppear {
                viewStore.send(.viewAppearing)
            }
        }
    }
    
    //MARK: - calendarHeader
    
    @ViewBuilder
    func calendarHeader(viewStore: 
                        ViewStore<CalendarFeature.State,
                        CalendarFeature.Action>
    ) -> some View {
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
                viewStore.send(.decrementMonthButtonTapped)
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(Color.brandColor(
                        color: .sub1)
                    )
                    .frame(width: 34,
                           height: 34)
            }
            
            Button {
                viewStore.send(.incrementMonthButtonTapped)
            } label: {
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color.brandColor(
                        color: .sub1)
                    )
                    .frame(width: 34,
                           height: 34)
            }
        }
    }
    
    //MARK: - dayOfWeekLabel
    
    @ViewBuilder
    func dayOfWeekLabel(viewStore: 
                        ViewStore<CalendarFeature.State,
                        CalendarFeature.Action>
    ) -> some View {
        HStack(spacing: 0) {
            ForEach(DayOfWeek.allCases, id: \.self) { dayOfWeek in
                Text(dayOfWeek.stringValue())
                    .pretendard(.body3)
            }
            .layoutOfCalendarItem()
        }
    }
    
    //MARK: - calendarGrid
    
    @ViewBuilder
    func calendarGrid(
        viewStore: ViewStore<CalendarFeature.State,
                            CalendarFeature.Action>
    ) -> some View {
        VStack(spacing: 0) {
            ForEach(viewStore.appearedDateComponentsMatrix,
                    id: \.self) { dateComponentsArray in
                HStack(spacing: 0) {
                    ForEach(dateComponentsArray,
                            id: \.self) { dateComponentsWithID in
                        CalendarGridItem(store: viewStore,
                                             dateComponents: dateComponentsWithID.dateComponents) {
                            viewStore.send(.dayComponentButtonTapped(dateComponentsWithID.dateComponents))
                        }
                    }
                }
            }
        }
    }
    
}

//MARK: - Preview

#Preview {
    CalendarView(store: .init(initialState: CalendarFeature.State(
        appearedYear: 0,
        appearedMonth: 0,
        appearedDay: 0,
        appearedDateComponentsMatrix: [],
        selectedDateComponents: nil),
                              reducer: {
        CalendarFeature().body
    }))
}
