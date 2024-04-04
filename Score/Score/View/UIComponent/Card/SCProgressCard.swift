//
//  SCProgressCard.swift
//  Score
//
//  Created by sole on 4/1/24.
//

import SwiftUI

//MARK: - SCProgressCard

// FIXME: 데이터 형식에 따라 구조 수정 필요
/// - Parameters:
///     - image: 유저의 프로필 이미지를 정의합니다.
///     - level: 유저의 레벨을 정의합니다.
///     - restPoint: 다음 레벨까지 남은 포인트를 정의합니다.
///     - progress: 레벨의 진척도를 정의합니다. 
struct SCProgressCard: View {
    let image: Image?
    let level: Int
    let restPoint: Int
    let progress: Double
    
    var body: some View {
        HStack(spacing: 12) {
            image?
                .resizable()
                .frame(width: 53, height: 53)
                .background {
                    Color.brandColor(color: .gray3)
                }
                .clipShape(Circle())
                
            
            VStack(alignment: .leading,
                   spacing: 4) {
                HStack {
                    Text("LV. \(level)")
                        .pretendard(weight: .bold,
                                    size: .s)
                        .foregroundStyle(Color.white)
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Text("다음 레벨까지")
                            .pretendard(weight: .regular,
                                        size: .xxs)
                            .foregroundStyle(Color.white)
                        
                        Text("\(restPoint) 포인트")
                            .pretendard(.caption)
                            .foregroundStyle(Color.white)
                    }
                }
                SCProgressBar(progress: progress)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 15)
        .background(Color.black,
                    in: RoundedRectangle(cornerRadius: 10))
    }
}

//MARK: - SCProgressCard 프리뷰입니다.

#Preview {
    SCProgressCard(image: nil,
                   level: 123,
                   restPoint: 1234,
                   progress: 0.8)
    .padding(.horizontal, 24)
}
