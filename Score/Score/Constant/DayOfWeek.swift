//
//  DayOfWeek.swift
//  Score
//
//  Created by sole on 4/12/24.
//

import Foundation

//MARK: - DayOfWeek

@frozen
enum DayOfWeek: Int,
                CaseIterable {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thusday
    case friday
    case saturday
    
    //MARK: - stringValue
    
    /// CalendarView에 사용되는 문자열을 반환합니다.
    func stringValue() -> String {
        switch self {
        case .monday:
            return "Mo"
        case .tuesday:
            return "Tu"
        case .wednesday:
            return "We"
        case .thusday:
            return "Th"
        case .friday:
            return "Fr"
        case .saturday:
            return "Sa"
        case .sunday:
            return "Su"
        }
    }
}
