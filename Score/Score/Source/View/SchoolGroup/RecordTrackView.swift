//
//  RecordTrackView.swift
//  Score
//
//  Created by sole on 8/25/24.
//

import SwiftUI

struct RecordTrackView: View {
    let lastRank: Int = 5
    
    var body: some View {
        VStack(spacing: 1) {
            ForEach(0..<lastRank) { row in
                if row == lastRank - 1 {
                    mateRecordSectionBuilder(rank: row)
                } else {
                    mateRecordSectionBuilder(rank: row)
                        .edgeBorder(edges: [.bottom],
                                    color: .white)
                }
            }
        }
        .frame(maxWidth: .deviceWidth)
        .overlay {
            Line(lineWidth: 1)
                .rotation(.degrees(90))
                .foregroundStyle(.white)
                .frame(width: CGFloat((lastRank) * 25 + (lastRank - 2) * 6 + 5))
                .frame(height:  1)
                .background(.blue)
//                .offset(x: 50)
        }
    }
    
    @ViewBuilder
    private func mateRecordSectionBuilder(rank: Int) -> some View {
        HStack(spacing: 32) {
            HStack(spacing: -12) {
                HStack(spacing: 0) {
                    Text("30'22\"")
                        .padding(.vertical, 2)
                        .padding(.horizontal, 6)
                        .background (
                            Color(hex: 0x2A3038, alpha: 0.4)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 9))
                    
                    Spacer()
                    
                    Text("연속 21일째")
                    
                    Image(.reactionFire)
                        .resizable()
                        .renderingMode(.template)
                        .rectFrame(size: 16)
                        .foregroundStyle(Color(hex: 0xAA8C3C))
                }
                .padding(.leading, 4)
                .padding(.trailing, 16)
                .frame(width: 190 - CGFloat(rank * 10))
                
                Image("")
                    .imagePlaceHolder(size: 25)
                    .overlay {
                        Circle()
                            .stroke(lineWidth: 1)
                            .foregroundStyle(.blue)
                    }
            }
            .background(
                Color.brandColor(color: .blue)
            )
            .clipShape(
                UnevenRoundedRectangle(
                    bottomTrailingRadius: 100,
                    topTrailingRadius: 100
                )
            )
            
            Spacer()
            
            HStack(spacing: 20) {
                Text("1")
                    .pretendard(weight: .bold,
                                size: .xs)
                    .padding(.leading, 12)
                
                Text("닉네임ㅁㅁ")
                    .lineLimit(1)
            }
            .edgeBorder(lineWidth: 1,
                        edges: [.leading],
                        color: .white)
            .frame(width: 100)
            
        }
        .foregroundStyle(.white)
        .pretendard(.caption)
        .padding(.top, 4)
        .padding(.bottom, 2.5)
        .background(
            Color.brandColor(color: .main)
        )
    }
}

#Preview {
    VStack{
        Spacer()
        RecordTrackView()
        Spacer()
    }
    .background(.black)
}
