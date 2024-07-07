//
//  SelectWorkOutTimeView.swift
//  Score
//
//  Created by sole on 6/30/24.
//

import SwiftUI

//MARK: - SelectWorkOutTimeView

struct SelectWorkOutTimeView: View {
    let nickName: String = "조파랑"
    @State var isPresentedTimeSelectSheet: Bool = false
    
    var body: some View {
        VStack(alignment: .leading,
               spacing: 36) {
            titleSectionBuilder()
            
            workOutButtonSection()
            
            Spacer()
        }
        .layout()
        .sheet(isPresented: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is Presented@*/.constant(false)/*@END_MENU_TOKEN@*/) {
            Text("운동 시간 선택 시트")
        }
    }
    
    //MARK: - titleSectionBuilder
    
    @ViewBuilder
    func titleSectionBuilder() -> some View {
        VStack(alignment: .leading,
               spacing: 4) {
            Text(Contexts.motivationMessage.rawValue)
                .pretendard(.subHeading)
                .foregroundStyle(
                    Color.brandColor(color: .text2)
                )
            
            VStack(alignment: .leading,
                   spacing: 0) {
                HStack(spacing: 0) {
                    Text(nickName)
                        .foregroundStyle(
                            Color.brandColor(color: .main)
                        )
                    
                    Text(Contexts.title.rawValue)
                        .foregroundStyle(
                            Color.brandColor(color: .text1)
                        )
                }
                
                Text(Contexts.continuedTitle.rawValue)
                    .foregroundStyle(
                        Color.brandColor(color: .text1)
                    )
            }
            .pretendard(weight: .semiBold,
                        size: .xxl)
        }
    }
    
    //MARK: - workOutButtonSection
    
    @ViewBuilder
    func workOutButtonSection() -> some View {
        SCTextField(style: .plain(error: nil),
                    placeHolder: Contexts.workOutTextFieldPlaceHolder.rawValue,
                    text: .constant(""))
        .onTapGesture {
            self.isPresentedTimeSelectSheet = true
        }
    }
    
    //MARK: - Contexts
    
    private enum Contexts: String {
        case title = "님이 운동할 시간을"
        case continuedTitle = "설정해주세요!"
        case motivationMessage = "꾸준히 운동할 수 있게 스코어가 도와드릴게요!"
        case workOutTextFieldPlaceHolder = "목표 운동 시간"
    }
}

//MARK: - Preview

#Preview {
    SelectWorkOutTimeView()
}
