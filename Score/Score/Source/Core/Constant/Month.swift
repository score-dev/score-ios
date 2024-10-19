//
//  Month.swift
//  Score
//
//  Created by sole on 4/12/24.
//

import SwiftUI

//MARK: - Month

@frozen
enum Month: Int {
    /// 1
    case january = 1
    /// 2
    case february
    /// 3
    case march
    /// 4
    case april
    /// 5
    case may
    /// 6
    case june
    /// 7
    case july
    /// 8
    case august
    /// 9
    case september
    /// 10
    case october
    /// 11
    case november
    /// 12
    case december
    
    //MARK: - capitalizedString
    
    /// 첫글자가 대문자인 문자열을 반환합니다.
    /// CalendarHeaderLabel에 사용됩니다. 
    func capitalizedString() -> String {
        switch self {
        case .january:
            return "January"
        case .february:
            return "February"
        case .march:
            return "March"
        case .april:
            return "April"
        case .may:
            return "May"
        case .june:
            return "June"
        case .july:
            return "July"
        case .august:
            return "August"
        case .september:
            return "September"
        case .october:
            return "October"
        case .november:
            return "November"
        case .december:
            return "December"
        }
    }
}


#Preview {
    Text(Month.january.capitalizedString())
}
