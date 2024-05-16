//
//  Constants.swift
//  Score
//
//  Created by sole on 4/1/24.
//

import SwiftUI

//MARK: - Constants

enum Constants {
    //MARK: - ImageName
    
    enum ImageName: String,
                    CaseIterable {
        // Plain Icons
        case heart
        case footsteps
        case check
        case bell
        case camera
        case close
        case download
        case loop
        case padlock
        case pencil
        case photograph
        case search
        case user
        case home
        case setting
        
        // Member Icons
        case dustMood = "dust.mood"
        case dustSad = "dust.sad"
        case dustSmile = "dust.smile"
        case groupUsers = "group.users"
        case mapMarker = "map.marker"
    
        case reactionConfetti = "reaction.confetti"
        case reactionFire = "reaction.fire"
        case reactionHappy = "reaction.happy"
        case reactionHeart = "reaction.heart"
        case reactionStar = "reaction.star"
        
        case weatherCloudy = "weather.cloudy"
        case weatherSnow = "weather.snow"
        case weatherSun = "weather.sun"
        
        case navigationUsers = "navigation.users"
        case chevronLeft = "chevron.left"
        case chevronRight = "chevron.right"
        case closeCircle = "close.circle"
        
        // Colored Icons
        case colorCamera = "color.camera"
        case colorRoad = "color.road"
        case colorLetter = "color.letter"
        case colorSprout = "color.sprout"
        case colorTea = "color.tea"
        
        case colorFirst = "color.first"
        case colorSecond = "color.second"
        case colorThird = "color.third"
        
        // Small Icons
        case triangleUp = "triangle.up"
        case triangleDown = "triangle.down"
        case arrowUp = "arrow.up"
        case arrowDown = "arrow.down"
        case flag
    }
    
    //MARK: - APIKey
    
    enum APIKey {
        //MARK: - Naver
        
        enum Naver: String {
            case clientID = "NAVER_CLIENT_ID"
            case secretKey = "NAVER_SECRET_KEY"
            
            //MARK: - findValueInBundle
            
            func findValueInBundle() -> String {
                Bundle.main.infoDictionary?[self.rawValue]
                as? String ?? "none"
            }
        }
    }
    
    //MARK: - Layout
    
    enum Layout: CGFloat {
        case horizontal = 16
        case navigationBarHeight = 56
        case iconSize = 24
    }
}

//MARK: - Preview

/// 모든 아이콘 이미지 에셋 프리뷰입니다.
#Preview {
    ScrollView {
        Text("SCIcon(templete, original)")
            .pretendard(.title)
        VStack {
            ForEach(Constants.ImageName.allCases,
                    id: \.self) { imageName in
                HStack {
                    Text(imageName.rawValue)
                        .pretendard(.body2)
                    Image(imageName.rawValue)
                        .renderingMode(.template)
                    Image(imageName.rawValue)
                        .renderingMode(.original)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}
