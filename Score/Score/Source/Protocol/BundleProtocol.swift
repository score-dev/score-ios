//
//  BundleProtocol.swift
//  Score
//
//  Created by sole on 5/21/24.
//

import Foundation

//MARK: - BundleProtocol

protocol BundleProtocol {
    var key: String { get }
    func getValueFromBundle() -> String?
}

//MARK: - BundleProtocol+getValueFromBundle

extension BundleProtocol {
    //MARK: - getValueFromBundle
    
    func getValueFromBundle() -> String? {
        Bundle.main.infoDictionary?[self.key] as? String
    }
}
