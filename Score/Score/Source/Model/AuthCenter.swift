//
//  AuthCenter.swift
//  Score
//
//  Created by sole on 5/21/24.
//

import SwiftUI

//MARK: - AuthCenter

enum AuthCenter: String {
    case kakao = "카카오"
    case google = "구글"
    case apple = "애플"
    
    //MARK: - imageName
    
    func imageName() -> Constants.ImageName {
        switch self {
        case .kakao:
            return .kakao
        case .google:
            return .google
        case .apple:
            return .apple
        }
    }
    
    //MARK: - backGroundColor
    
    func backGroundColor() -> Color {
        switch self {
        case .kakao:
            return .brandColor(color: .kakaoBackground)
        case .google:
            return .white
        case .apple:
            return .white
        }
    }
}
