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
                    CaseIterable,
                    ImageAssetProtocol {
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
        
        // Auth center Icon
        case kakao
        case naver
        case google
        case apple
        
        // Brand Icon
        case brandIcon
        
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
        
        //MARK: - ScoreCharacter
        
        /// 프로필 이미지에 쓰일 스코어 캐릭터 이미지 열거형입니다.
        enum ScoreCharacter: String,
                             CaseIterable,
                             ImageAssetProtocol {
            case rabbit
            case turtle
            case dog
            case panda
            case cat
        }
        
        //MARK: - OnBoarding
        
        enum OnBoarding: String,
                         CaseIterable,
                         ImageAssetProtocol {
            // OnBoarding Image
            case record = "onboarding.record"
            case group = "onboarding.group"
            case feed = "onboarding.feed"
            case school = "onboarding.school"
        }
        
        // MARK: - Record
        
        enum Record: String,
                     ImageAssetProtocol {
            case track = "track"
        }
    }
    
    //MARK: - APIKey
    
    enum APIKey: String,
                 APIKeyProtocol {
        case serverBaseURL = "SERVER_BASE_URL"
        
        //MARK: - Naver
        
        enum Naver: String,
                    APIKeyProtocol {
            case clientID = "NAVER_CLIENT_ID"
            case secretKey = "NAVER_SECRET_KEY"
        }
        
        //MARK: - Kakao
        
        enum Kakao: String,
                    APIKeyProtocol {
            case appID = "KAKAO_APP_ID"
        }
        
        //MARK: - Google
        
        enum Google: String,
                     APIKeyProtocol {
            case clientID = "GIDClientID"
            case reversedClientID = "GOOGLE_REVERSED_CLIENT_ID"
        }
    }
    
    //MARK: - Layout
    
    enum Layout: CGFloat {
        case horizontal = 16
        case navigationBarHeight = 56
        case iconSize = 24
    }
}

//MARK: - Constants.ImageName.OnBoarding+

extension Constants.ImageName.OnBoarding {
    static subscript(index: Int) -> Image {
        let allCases = Constants.ImageName.OnBoarding.allCases
        
        guard index > -1
        else { return allCases[0].image() }
        
        guard index < allCases.count
        else { return allCases[allCases.count-1].image() }
        
        return allCases[index].image()
    }
}

//MARK: - Constants.ImageName.ScoreCharacter+

extension Constants.ImageName.ScoreCharacter {
    var backgroundColor: Color {
        switch self {
        case .rabbit:
            return .brandColor(color: .lightRed)
        case .turtle:
            return .brandColor(color: .lightGreen)
        case .dog:
            return .brandColor(color: .lightYellow)
        case .panda:
            return .brandColor(color: .lightGray)
        case .cat:
            return .brandColor(color: .lightBlue)
        }
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
