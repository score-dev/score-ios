//
//  SCLineTabProtocol.swift
//  Score
//
//  Created by sole on 5/27/24.
//

import Foundation

// - FIXME: 이름 재지정 필요
typealias SCLineTabProtocol = Hashable & Equatable & CaseIterable

protocol SCLineTabBarItemProtocol: Hashable {
    associatedtype Tab: SCLineTabProtocol
    
    var title: String { get set }
    var tab: Tab { get set }
}

struct SCLineTabItem<Tab: SCLineTabProtocol>: SCLineTabBarItemProtocol {
    var title: String
    var tab: Tab
}
