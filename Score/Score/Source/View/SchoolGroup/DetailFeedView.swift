//
//  DetailFeedView.swift
//  Score
//
//  Created by sole on 8/25/24.
//

import SwiftUI

struct DetailFeedView: View {
    @State var isPresentEmojiSection: Bool = false
    @State var selectedEmoji: String?
    @State var isPresentedPopUp: Bool = false
    private let emojis: [String] = ["❤️", "👍", "🎉", "🙌"]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("")
                    .imagePlaceHolder(size: 39)
                
                VStack {
                    Text("닉네임")
                        .pretendard(.body2)
                        .foregroundStyle(
                            Color.brandColor(color: .text1)
                        )
                    
                    Text("5분 전")
                        .pretendard(.caption)
                        .foregroundStyle(
                            Color.brandColor(color: .text3)
                        )
                }
                
                Spacer()
                
                SCIconButton(imageName: .dots, size: 18) {
                    // to appear setting
                    isPresentedPopUp = true
                }
            }
            .padding(.vertical, 13)
            .layout()
            
            VStack(spacing: 16) {
                Image("")
                    .resizable()
                    .rectFrame(size: .deviceWidth)
                    .background(Color.brandColor(color: .gray2))
                
                
                emotionSectionBuilder()
                
                feedInfoSectionBuilder()
            }
        }
        // confirmDialog
        .onTapGesture {
            isPresentEmojiSection = false
        }
    }
    
    @ViewBuilder
    private func emotionSectionBuilder() -> some View {
        HStack {
            Button {
                isPresentEmojiSection.toggle()
            } label: {
                Text(selectedEmoji == nil ? "😃" : selectedEmoji!)
                    .padding(9)
                    .background(
                        selectedEmoji == nil ?
                        Color.brandColor(color: .gray2) :
                        Color.brandColor(color: .sub3)
                    )
                    .clipShape(Circle())
            }
            
            Spacer()
        }
        .layout()
        .overlay(alignment: .topLeading) {
            if isPresentEmojiSection {
                emotionButtonSectionBuilder()
                    .offset(x: 20,y: -55)
            }
        }
    }
    
    @ViewBuilder
    private func emotionButtonSectionBuilder() -> some View {
        HStack(spacing: 20) {
            ForEach(emojis, id: \.self) { emoji in
                Button {
                    // select emoji
                    if selectedEmoji == emoji {
                        selectedEmoji = nil
                    } else {
                        selectedEmoji = emoji
                    }
                    isPresentEmojiSection = false
                } label: {
                    Text("\(emoji)")
                        .pretendard(weight: .bold,
                                    size: .xxl)
                        .rectFrame(size: 32)
                        .background {
                            if selectedEmoji == emoji {
                               Circle()
                                    .foregroundStyle(
                                        Color.brandColor(color: .gray2)
                                    )
                            }
                        }
                }
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .background(.white)
        .clipShape(Capsule())
        .shadow(radius: 10, y: 2)
    }
    
    @ViewBuilder
    private func feedInfoSectionBuilder() -> some View {
        VStack(alignment: .leading,
               spacing: 16) {
            positionInfoSectionBuilder()
            
            mateInfoSectionBuilder()
        }
        .layout()
    }
    
    @ViewBuilder
    private func positionInfoSectionBuilder() -> some View {
        HStack(spacing: 8) {
            HStack(spacing: 4) {
                HStack {
                    Image("")
                        .imagePlaceHolder(size: 24)
                        .background(Color.gray)
                    
                    Text("백이진")
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .chipViewModifier(style: .capsule,
                                  backgroundColor: .brandColor(color: .gray2))
                
                Text("님이")
            }
            
            HStack(spacing: 4) {
                HStack {
                    Image(.mapMarker)
                        .resizable()
                        .rectFrame(size: 20)
                    
                    Text("시청역 5번 출구")
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .chipViewModifier(style: .capsule,
                                  backgroundColor: .brandColor(color: .gray2))
                
                Text("에서")
            }
        }
        .pretendard(weight: .medium,
                    size: .xs)
        .foregroundStyle(
            Color.brandColor(color: .text1)
        )
        .frame(maxWidth: .infinity,
               alignment: .leading)
    }
    
    @ViewBuilder
    private func mateInfoSectionBuilder() -> some View {
        HStack(spacing: 6) {
            HStack(spacing: 4) {
                HStack(spacing: 4) {
                    Image("")
                        .imagePlaceHolder(size: 24)
                        .background(Color.gray)
                    
                    Text("파묘 흥행 ")
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .chipViewModifier(style: .capsule,
                                  backgroundColor: .brandColor(color: .gray2))
                
                Text("님과 함께")
            }
            
            HStack(spacing: 6) {
                Text("30분")
                    .foregroundStyle(.white)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 13)
                    .chipViewModifier(style: .roundedRectangle,
                                      backgroundColor: .black)
                
                Text("동안 운동했어요")
            }
        }
        .pretendard(weight: .medium,
                    size: .xs)
        .foregroundStyle(
            Color.brandColor(color: .text1)
        )
    }
}

#Preview {
    DetailFeedView()
}
