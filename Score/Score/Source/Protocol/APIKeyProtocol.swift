//
//  APIKeyProtocol.swift
//  Score
//
//  Created by sole on 5/21/24.
//

import Foundation

/// APIKey를 불러올 때 사용되는 열거형에 적용합니다.
//MARK: - APIKeyProtocol

protocol APIKeyProtocol: BundleProtocol {
    var rawValue: String { get }
}

//MARK: - APIKeyProtocol

extension APIKeyProtocol {
    //MARK: - findValueInBundle
    var key: String {
        return self.rawValue
    }
}
