//
//  DetailFeedView.swift
//  Score
//
//  Created by sole on 8/25/24.
//

import SwiftUI

struct DetailFeedView: View {
    @State var isPresentFeedSettingDialog: Bool = false
    @State var isPresentEmojiSection: Bool = false
    @State var isPresentEmojiListSheet: Bool = false
    @State var selectedEmoji: String?
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
                    isPresentFeedSettingDialog = true
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

                hashtagSectionBuilder()
            }
        }
        .confirmationDialog(
            Text("피드를 신고하시겠습니까?"),
            isPresented: $isPresentFeedSettingDialog,
            titleVisibility: .hidden
        ) {
            // 내 피드가 아닌 경우
            Button(role: .destructive) {
                // navigation to feed report view
            } label: {
                Text("피드 신고하기")
            }
            
            // 내 피드인 경우
        }
        .sheet(isPresented: $isPresentEmojiListSheet) {
            Text("반응 sheet")
        }
        .onTapGesture {
            isPresentEmojiSection = false
        }
    }
    
    @ViewBuilder
    private func emotionSectionBuilder() -> some View {
        HStack {
            Button {
                isPresentEmojiSection.toggle()
                HapticGenerator.shared.impactOccurred()
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
            .onLongPressGesture(minimumDuration: 1) {
                isPresentEmojiListSheet = true
                HapticGenerator.shared.impactOccurred()
            }

            Spacer()
        }
        .layout()
        .overlay(alignment: .topLeading) {
            if isPresentEmojiSection {
                emotionButtonSectionBuilder()
                    .offset(x: 20, y: -55)
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

    @ViewBuilder
    private func hashtagSectionBuilder() -> some View {
        HStack(spacing: 10) {
            ForEach(0..<3) { _ in
                Text("#맑은")
                    .pretendard(.caption)
                    .foregroundStyle(Color.brandColor(color: .main))
                    .padding(.vertical, 7)
                    .padding(.horizontal, 14)
                    .background {
                        RoundedRectangle(cornerRadius: 50)
                            .foregroundStyle(Color.brandColor(color: .sub3))
                    }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .layout()
    }
}

#Preview {
    DetailFeedView()
}
