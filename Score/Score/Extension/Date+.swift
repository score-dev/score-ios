//
//  Date+.swift
//  Score
//
//  Created by sole on 4/11/24.
//

import Foundation

//MARK: - Date+

extension Date {
    //MARK: - nowDate
    
    /// 사용자의 현재 날짜의 연도, 월, 일을 튜플 형태로 반환합니다.
    /// - Returns: (year: 연도, month: 월, day: 일)
    static func nowDate() -> (year: Int,
                              month: Int,
                              day: Int) {
        return (year: Date.now.year(),
                month: Date.now.month(),
                day: Date.now.day())
    }
    
    //MARK: - year
    
    /// 대상 Date의 연도를 Int 형태로 반환합니다.
    func year() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        return Int(
            dateFormatter.string(from: self)
        ) ?? 0000 // invalid year
    }
    
    //MARK: - month
    
    /// 대상 Date의 월을 Int 형태로 반환합니다.
    func month() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return Int(
            dateFormatter.string(from: self)
        ) ?? 00 // invalid month
    }
    
    //MARK: - day
    
    /// 대상 Date의 일을 Int 형태로 반환합니다.
    func day() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return Int(
            dateFormatter.string(from: self)
        ) ?? 00 // invalid day
    }
}
