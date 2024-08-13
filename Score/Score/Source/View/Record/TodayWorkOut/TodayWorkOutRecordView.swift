//
//  TodayWorkOutRecordView.swift
//  Score
//
//  Created by sole on 7/12/24.
//

import SwiftUI

// MARK: - TodayWorkOutRecordView

struct TodayWorkOutRecordView: View {
    var body: some View {
        VStack(alignment: .leading,
               spacing: 12) {
            // have to change to map
            RoundedRectangle(cornerRadius: 28)
            
            todayWorkOutHistorySectionBuilder()
            
            weekWorkOutHistorySectionBuilder()
            
            SCButton(style: .primary) {
                
            } label: {
                Text("피드 업로드하러 출발하기")
                    .frame(maxWidth: .infinity)
            }
        }
        .layout()
        .scNavigationBar(
            backgroundColor: .brandColor(color: .gray2)
        ) {
            DismissButton(style: .chevron) {
                
            }
            
            Text("오늘의 운동기록")
                .pretendard(.title)
            
            Spacer()
        }
        .background(
            Color.brandColor(color: .gray2)
        )
    }
    
    // MARK: - todayWorkOutHistorySectionBuilder
    
    @ViewBuilder
    func todayWorkOutHistorySectionBuilder() -> some View {
        VStack(spacing: 12) {
            VStack(spacing: -4) {
                Text("운동시간")
                    .pretendard(.body3)
                    .foregroundStyle(
                        Color.brandColor(color: .text3)
                    )
                
                Text("00:00")
                    .pretendard(
                        weight: .bold,
                        size: .ultra
                    )
            }
                
            HStack {
                VStack(spacing: 4) {
                    Text("이동 거리")
                        .pretendard(.body3)
                        .foregroundStyle(
                            Color.brandColor(color: .text3)
                        )
                    
                    AttributedText {
                        Text("000")
                            .pretendard(
                                weight: .bold,
                                size: .xxl
                            )
                        
                        Text("m")
                            .pretendard(
                                weight: .semiBold,
                                size: .m
                            )
                    }
                }
                .padding(.horizontal, 40)
                
                Divider()
                
                VStack(spacing: 4) {
                    Text("소모한 칼로리")
                        .pretendard(.body3)
                        .foregroundStyle(
                            Color.brandColor(color: .text3)
                        )
                    
                    AttributedText {
                        Text("000")
                            .pretendard(
                                weight: .bold,
                                size: .xxl
                            )
                        Text("kcal")
                            .pretendard(
                                weight: .semiBold,
                                size: .m
                            )
                    }
                }
                .padding(.horizontal, 40)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
    }
    
    // MARK: - weekWorkOutHistorySectionBuilder
    
    @ViewBuilder
    func weekWorkOutHistorySectionBuilder() -> some View {
        VStack(alignment: .leading,
               spacing: 12) {
            VStack(alignment: .leading,
                   spacing: 4) {
                // 2day color have to be changed to main color
                AttributedText {
                    Text("매일매일 연속으로 운동한지")
                        .pretendard(.body2)
                        .foregroundStyle(
                            Color.brandColor(color: .text1)
                        )
                    
                    Text("2일째")
                        .pretendard(.body2)
                        .foregroundStyle(
                            Color.brandColor(color: .main)
                        )
                }
                
                Text("7일 연속 기록을 채우고 그룹 내 1등에 도전해보세요!")
                    .pretendard(.caption)
                    .foregroundStyle(
                        Color.brandColor(color: .text3)
                    )
            }
                
            HStack {
                ForEach(0..<7,
                        id: \.self) { index in
                    SCIcon(
                        style: .init(
                            imageSize: 19,
                            circleSize: 32,
                            imageColor: .brandColor(color: .main),
                            circleColor: .brandColor(color: .sub2)
                        ),
                        imageName: .check
                    )
                    
                    if index < 6 {
                        Spacer()
                    }
                }
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
        
    }
}

// MARK: - Preview

#Preview {
    TodayWorkOutRecordView()
}
