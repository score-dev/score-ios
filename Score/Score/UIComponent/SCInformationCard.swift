//
//  SCInformationCard.swift
//  Score
//
//  Created by sole on 4/1/24.
//

import SwiftUI

//MARK: - Weather

enum Weather: String {
    case sun
    case cloudy
    case snow
    case rain
    
    func imageName() -> String {
        switch self {
        case .sun:
            return Constant.ImageName.weatherSun.rawValue
        case .cloudy:
            return Constant.ImageName.weatherCloudy.rawValue
        case .snow:
            return Constant.ImageName.weatherSnow.rawValue
        case .rain:
            return Constant.ImageName.weatherSnow.rawValue
        }
    }
}

//MARK: - Dust

enum Dust: String  {
    case bad = "나쁨"
    case regular = "보통"
    case good = "좋음"
    
    func imageName() -> String {
        switch self {
        case .bad:
            return Constant.ImageName.dustSad.rawValue
        case .regular:
            return Constant.ImageName.dustMood.rawValue
        case .good:
            return Constant.ImageName.dustSmile.rawValue
        }
    }
}

//MARK: - SCInformationCardStyle

enum SCInformationCardStyle{
    case weather(weather: Weather,
                 temperature: Int)
    case dust(dust: Dust)
    case time(time: Int)
    case rate(rate: Int)
}

//MARK: - SCInformationCard

struct SCInformationCard: View {
    let style: SCInformationCardStyle
    
    var body: some View {
        labelBuilder()
            .background(Color.brandColor(color: .gray2),
                        in: RoundedRectangle(cornerRadius: 7))
    }
    
    @ViewBuilder
    func labelBuilder() -> some View {
        switch style {
        case .weather(let weather,
                      let temperature):
            VStack(spacing: 8) {
                Text("날씨")
                    .pretendard(.body3)
                    .foregroundStyle(Color.brandColor(color: .text3))
                
                SCLabel(style: .card,
                        imageName: weather.imageName(),
                        title: "\(temperature)")
            }
            .padding(.vertical, 13)
            .padding(.horizontal, 46)
            
        case .dust(let dust):
            VStack(spacing: 8) {
                Text("미세먼지")
                    .pretendard(.body3)
                    .foregroundStyle(Color.brandColor(color: .text3))
                
                SCLabel(style: .card,
                        imageName: dust.imageName(),
                        title: "\(dust)")
            }
            .padding(.vertical, 13)
            .padding(.horizontal, 46)
            
        case .time(let time):
            VStack(spacing: 4) {
                Text("누적 운동 시간")
                    .pretendard(.body3)
                    .foregroundStyle(Color.brandColor(color: .text3))
                
                Text("\(time)시간")
                    .pretendard(.body2)
                    .foregroundStyle(Color.brandColor(color: .text1))
            }
            .padding(.vertical, 11)
            .padding(.horizontal, 46)
            
        case .rate(let rate):
            VStack(spacing: 4) {
                Text("일주일 평균 참여율")
                    .pretendard(.caption)
                    .foregroundStyle(Color.brandColor(color: .text3))
                
                Text("\(rate)%")
                    .pretendard(.body2)
                    .foregroundStyle(Color.brandColor(color: .text1))
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 29)
        }
    }
    
}

//MARK: - Preview

/// 모든 SCInformationCard의 프리뷰입니다.
#Preview {
    VStack {
        SCInformationCard(style: .dust(dust: .good))
        SCInformationCard(style: .weather(weather: .cloudy,
                                          temperature: 12))
        SCInformationCard(style: .time(time: 10))
        SCInformationCard(style: .rate(rate: 10))
    }
}
