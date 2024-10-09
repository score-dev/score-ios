//
//  CalendarFeature.swift
//  Score
//
//  Created by sole on 4/11/24.
//

import ComposableArchitecture
import SwiftUI

//MARK: - CalendarFeature

struct CalendarFeature: Reducer {
    @Dependency(\.calendar) var calendar
    @Dependency(\.uuid) var uuidGenerator
    
    // range of calendar view
    /// 캘린더에서 볼 수 있는 연도의 범위를 정의합니다.
    /// 현재 연도 전후로 10년을 범위로 정의합니다.
    private var validYearRange: ClosedRange<Int> = Date.nowDate().year - 10...Date.nowDate().year + 10
    /// 캘린더에서 볼 수 있는 월의 범위를 정의합니다.
    private var validMonthRange: ClosedRange<Int> = 1...12
    /// 캘린더에서 볼 수 있는 일의 범위를 정의합니다.
    private var validDayRange: ClosedRange<Int> = 1...31
    
    /// 한 달에 들어갈 수 있는 최대 주의 개수를 정의합니다.
    private let maxNumberOfWeekInMonth: Int = 6
    /// 한 주에 들어갈 수 있는 최대 일의 개수를 정의합니다.
    private let maxNumberOfDayInWeek: Int = 7
    
    struct State: Equatable {
        var appearedYear: Int = Date.nowDate().year
        var appearedMonth: Int = Date.nowDate().month
        var appearedDay: Int = Date.nowDate().day
        var appearedDateComponentsMatrix: [[DateComponentsWithID]] = []
        var selectedDateComponents: DateComponents?
    }
    
    enum Action {
        case viewAppearing
//        case tasking
        case incrementMonthButtonTapped
        case decrementMonthButtonTapped
        case calendarUpdating
        case dayComponentButtonTapped(DateComponents?)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppearing:
//                // 현재 날짜로 세팅합니다.
                 // 탭바로 appearing 시 이전 상황이 저장되지 않아서 삭제합니다. 
//                let nowDate = Date.nowDate()
//                state.appearedYear = nowDate.year
//                state.appearedMonth = nowDate.month
//                state.appearedDay = nowDate.day
                return .send(.calendarUpdating)
                
            case .incrementMonthButtonTapped:
                /// 12월을 넘어가지 않는 경우만 판별
                guard validMonthRange.contains(state.appearedMonth + 1)
                    else {
                    // year exception
                    state.appearedYear += 1
                    state.appearedMonth = 1
                    return .send(.calendarUpdating)
                }
                state.appearedMonth += 1
                return .send(.calendarUpdating)
                
            case .decrementMonthButtonTapped:
                /// 1월보다 작지 않은 경우만 판별
                guard validMonthRange.contains(state.appearedMonth - 1)
                else {
                    // year exception
                    state.appearedYear -= 1
                    state.appearedMonth = 12
                    return .send(.calendarUpdating)
                }
                
                state.appearedMonth -= 1
                return .send(.calendarUpdating)
                
            case .calendarUpdating:
                // 해당하는 dateComponents를 모두 찾습니다.
                let dateComponentsArray = dateComponentsInMonth(
                                            year: state.appearedYear,
                                            month: state.appearedMonth
                                            )
                // 2차원 배열로 변환합니다.
                state.appearedDateComponentsMatrix = dateComponentsArrayToMatrix(with: dateComponentsArray)
                return .none
                
            case .dayComponentButtonTapped(let dateComponents):
                state.selectedDateComponents = dateComponents
                return .none
            }
        }
    }
    
    //MARK: - dateComponentsInMonth
    
    /// 지정한 연도, 월에 포함되는 valid한 DateComponents들을 담은 1차원 배열을 반환합니다.
    /// - Parameters:
    ///     - year: DateComponents를 반환할 연도를 정의합니다.
    ///     - month: DateComponents를 반환할 월을 정의합니다.
    private func dateComponentsInMonth(year: Int,
                                       month: Int) -> [DateComponents] {
        var dateComponentsArray: [DateComponents] = []
        
        for day in validDayRange {
            let dateComponents = DateComponents(
                calendar: self.calendar,
                year: year,
                month: month,
                day: day)
            
            guard dateComponents.isValidDate
            else { continue }
           
            dateComponentsArray.append(dateComponents)
        }
    
        return dateComponentsArray
    }
    
    //MARK: - dateComponentsArrayToMatrix
    
    /// 1차원 DateComponent 배열을 2차원 DateComponentWith 배열로 반환합니다.
    /// ForEach에서 nil 값을 구분하기 위해 id가 있는 model로 반환합니다.
    /// - Parameters:
    ///     - with: 2차원 배열로 반환할 1차원 배열을 정의합니다.
    private func dateComponentsArrayToMatrix(
        with dateComponentsArray: [DateComponents]
    ) -> [[DateComponentsWithID]] {
        var matrix: [[DateComponentsWithID]] = []
//        var matrix: [[DateComponentsWithID]] = Array(
//            repeating: Array(
//                repeating: DateComponentsWithID(id: uuidGenerator.callAsFunction(),
//                                                dateComponents: nil),
//                count: maxNumberOfDayInWeek
//            ),
//            count: maxNumberOfWeekInMonth)
//    
        // 위와 같이 구현하면 같은 uuid가 들어감. why...?
        // Array(repeating: count:)가 같은 uuid로 repeating하나?
        for _ in 0..<maxNumberOfWeekInMonth {
            var subArray: [DateComponentsWithID] = []
            for _ in 0..<maxNumberOfDayInWeek {
                subArray.append(DateComponentsWithID(id: uuidGenerator.callAsFunction()))
                }
            matrix.append(subArray)
        }
        
        for dateComponents in dateComponentsArray {
            guard let dateOfDateComponents = dateComponents.date
                    
            else { continue }
            
            let convertedDateComponents = calendar.dateComponents(
                [.year,
                 .month,
                 .day,
                 .weekOfMonth,
                 .weekday
                ],
                from: dateOfDateComponents
            )
            
            guard let weekOfMonth = convertedDateComponents.weekOfMonth,
                  let weekday = convertedDateComponents.weekday
            else {
                continue
            }
            
            matrix[weekOfMonth - 1][weekday - 1].dateComponents = dateComponents
        }
        // 아무것도 없는 주간은 반환하지 않도록 합니다.
        return matrix.filter { subArray in
            subArray.contains { dateComponentsWithID in
                // 하나라도 날짜가 들어있는 배열만 반환
                dateComponentsWithID.dateComponents != nil
            }
        }
    }
}
