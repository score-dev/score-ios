//
//  ImageAssetProtocol.swift
//  Score
//
//  Created by sole on 6/1/24.
//

import SwiftUI

//MARK: - ImageAssetProtocol

protocol ImageAssetProtocol {
    var rawValue: String { get }
    func image() -> Image
}

//MARK: - ImageAssetProtocol+image

extension ImageAssetProtocol {
    func image() -> Image {
        Image(self.rawValue)
    }
}
