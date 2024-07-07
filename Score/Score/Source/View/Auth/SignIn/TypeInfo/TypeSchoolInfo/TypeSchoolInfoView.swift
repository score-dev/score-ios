//
//  TypeSchoolInfoView.swift
//  Score
//
//  Created by sole on 6/29/24.
//

import SwiftUI

//MARK: - TypeSchoolInfoView

struct TypeSchoolInfoView: View {
    let nickName: String = "조파랑"
    @State var isPresentedSchoolNameSheet: Bool = false
    @State var isPresentedGradeSheet: Bool = false
    
    var body: some View {
        VStack(alignment: .leading,
               spacing: 32) {
            titleBuilder()
            
            schoolInfoSectionBuilder()
            
            Spacer()
        }
        .layout()
        .sheet(isPresented: $isPresentedSchoolNameSheet) {
                Text("학교 이름")
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $isPresentedGradeSheet) {
            Text("학년")
                .presentationDetents([.medium])
        }
    }
    
    //MARK: - titleBuilder
    
    @ViewBuilder
    private func titleBuilder() -> some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                Text("\(nickName)")
                    .foregroundStyle(Color.brandColor(color: .main))
                
                Text(Contexts.title.rawValue)
                    .foregroundStyle(Color.brandColor(color: .text1))
            }
            
            Text(Contexts.continuedTitle.rawValue)
                .foregroundStyle(Color.brandColor(color: .text1))
        }
        .pretendard(weight: .semiBold,
                    size: .xxl)
    }
    
    //MARK: - schoolInfoSectionBuilder
    
    @ViewBuilder
    func schoolNameSectionBuilder() -> some View {
        VStack(alignment: .leading,
               spacing: 6) {
            Text(Contexts.schoolName.rawValue)
                .pretendard(weight: .regular,
                            size: .xxs)
                .foregroundStyle(
                    Color.brandColor(color: .text3)
                )
            // FIXME: tap gesture가 textfield와 겹쳐서 modal 시트가 안 나옴. 새로 modifier를 만들거나 디자인 상의 필요
            SCTextField(style: .plain(error: nil),
                        placeHolder: Contexts.schoolName.rawValue,
                        text: .constant(nickName))
            .disabled(true)
            .background(Color.white)
            .onTapGesture {
                self.isPresentedSchoolNameSheet = true
            }
        }
    }
    
    @ViewBuilder
    func schoolGradeSectionBuilder() -> some View {
        VStack(alignment: .leading,
               spacing: 6) {
            Text(Contexts.grade.rawValue)
                .pretendard(weight: .regular,
                            size: .xxs)
                .foregroundStyle(
                    Color.brandColor(color: .text3)
                )
            // FIXME: tap gesture가 textfield와 겹쳐서 modal 시트가 안 나옴. 새로 modifier를 만들거나 디자인 상의 필요
            SCTextField(style: .plain(error: nil),
                        placeHolder: Contexts.grade.rawValue,
                        text: .constant(nickName))
            .disabled(true)
            .background(Color.white)
            .onTapGesture {
                self.isPresentedGradeSheet = true
            }
        }
    }
    
    @ViewBuilder
    func schoolInfoSectionBuilder() -> some View {
        VStack(alignment: .leading,
               spacing: 24) {
            schoolNameSectionBuilder()
            
            schoolGradeSectionBuilder()
        }
    }
    
    //MARK: - Contexts
    
    private enum Contexts: String {
        case title = "님이 다니고 있는"
        case continuedTitle = "학교에 대해 알려주세요!"
        case schoolName = "학교 이름"
        case grade = "학년"
    }
}

//MARK: - Preview

#Preview {
    TypeSchoolInfoView()
}
