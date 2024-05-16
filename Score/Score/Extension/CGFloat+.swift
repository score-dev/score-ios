//
//  CGFloat+.swift
//  Score
//
//  Created by sole on 4/27/24.
//

import UIKit

//MARK: - CGFloat

extension CGFloat {
    //MARK: - device size
    static let deviceWidth = UIScreen.main.bounds.width
    static let deviceHeight = UIScreen.main.bounds.height
    
    //MARK: - calendarItemSize
    static var calendarItemSize: CGFloat {
        let paddingHorizontal: CGFloat = Constants.Layout.horizontal.rawValue * 2
        return (.deviceWidth - paddingHorizontal) / 7
    }
}
