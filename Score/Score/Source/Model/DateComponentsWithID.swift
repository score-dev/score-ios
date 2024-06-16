//
//  DateComponentsWithID.swift
//  Score
//
//  Created by sole on 4/12/24.
//

import Foundation

struct DateComponentsWithID: Identifiable,
                             Hashable {
    let id: UUID
    var dateComponents: DateComponents?
}
