//
//  ProfileEditView.swift
//  Score
//
//  Created by sole on 4/12/24.
//

import ComposableArchitecture
import SwiftUI

//MARK: - ProfileEditView

struct ProfileEditView: View {
    let store: StoreOf<ProfileEditFeature>
    @ObservedObject var viewStore: ViewStoreOf<ProfileEditFeature>
    
    let constant = Contexts.MyPage.self
    
    //MARK: - init
    
    init(store: StoreOf<ProfileEditFeature>) {
        self.store = store
        self.viewStore = ViewStore(store,
                                   observe: { $0 })
    }
    
    //MARK: - body
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading,
                   spacing: 28) {
                profileImageSectionBuilder()
                
                nickNameSectionBuilder()
                
                workOutAlarmTimeSectionBuilder()
                
                schoolSectionBuilder()
                
                gradeSectionBuilder()
                
                sexSelectSectionBuilder()
                
                heightAndWeightSectionBuilder()
                
                SCButton(style: .primary) {
                    viewStore.send(.editDoneButtonTapped)
                } label: {
                    Text("저장하기")
                        .frame(maxWidth: .infinity)
                }
            }
            .layout()
        }
        .scNavigationBar {
            DismissButton(style: .chevron) {
                viewStore.send(.dismissButtonTapped)
            }
            
            Text("마이페이지")
        }
        .sheet(isPresented: viewStore.$isPresentingEditWorkOutTime) {
            Text("운동 시간 설정 Sheet")
        }
        .sheet(isPresented: viewStore.$isPresentingEditSchoolSheet) {
            Text("학교 설정 Sheet")
        }
        .sheet(isPresented: viewStore.$isPresentingEditGradeSheet) {
            Text("학년 설정 Sheet")
        }
    }
    
    //MARK: - profileImageSectionBuilder
    
    /// 프로필 이미지를 수정할 수 있는 부분 뷰입니다.
    @ViewBuilder
    func profileImageSectionBuilder() -> some View {
        viewStore.displayedProfileImage
            .imagePlaceHolder(size: 130)
            .overlay(alignment: .bottomTrailing) {
                PhotoPickerView(
                    store: store.scope(state: \.photoPicker,
                                       action: \.photoPicker)
                ) {
                    SCIcon(
                        style: .init(
                            size: .medium,
                            color: .gray3
                        ),
                        imageName: .pencil)
                }
            }
            .frame(maxWidth: .infinity)
    }
    
    //MARK: - nickNameSectionBuilder
    
    /// 닉네임을 수정할 수 있는 부분 뷰입니다.
    @ViewBuilder
    func nickNameSectionBuilder() -> some View {
        Text(viewStore.displayedNickName)
            .pretendard(.body2)
            .foregroundStyle(
                Color.brandColor(color: .text1)
            )
        
        SCTextField(style: .line(),
                    placeHolder: constant.nickNamePlaceHolder.rawValue,
                    text: viewStore.$displayedNickName)
    }
    
    //MARK: - workOutAlarmTimeSectionBuilder
    
    /// 알람 시간을 수정할 수 있는 부분 뷰입니다.
    @ViewBuilder
    func workOutAlarmTimeSectionBuilder() -> some View {
        Text("운동 알람 시간")
            .pretendard(.body2)
            .foregroundStyle(Color.brandColor(color: .text1))
        
        SCButton(style: .gray) {
            store.send(.workOutTimeButtonTapped)
        } label: {
            Text("매일 오전 00:00")
                .pretendard(.body1)
                .foregroundStyle(Color.brandColor(color: .text1))
                .frame(maxWidth: .infinity)
        }
    }
    
    //MARK: - schoolSectionBuilder
    
    /// 학교를 수정할 수 있는 부분 뷰입니다.
    @ViewBuilder
    func schoolSectionBuilder() -> some View {
        Text("학교")
            .pretendard(.body2)
            .foregroundStyle(Color.brandColor(color: .text1))
        
        SCButton(style: .gray) {
            viewStore.send(.schoolEditButtonTapped)
        } label: {
            Text(viewStore.displayedSchool)
                .foregroundStyle(Color.brandColor(color: .text1))
                .frame(maxWidth: .infinity)
        }
    }
    
    //MARK: - gradeSectionBuilder
    
    /// 학년을 수정할 수 있는 부분 뷰입니다.
    @ViewBuilder
    func gradeSectionBuilder() -> some View {
        Text("학년")
            .pretendard(.body2)
            .foregroundStyle(Color.brandColor(color: .text1))
        
        SCButton(style: .gray) {
            viewStore.send(.gradeEditButtonTapped)
        } label: {
            Text("\(viewStore.state.displayedGrade)학년")
                .foregroundStyle(Color.brandColor(color: .text1))
                .frame(maxWidth: .infinity)
        }
    }
    
    //MARK: - sexSelectSectionBuilder
    
    /// 성별을 수정할 수 있는 부분 뷰입니다.
    @ViewBuilder
    func sexSelectSectionBuilder() -> some View {
        Text("성별")
            .pretendard(.body2)
            .foregroundStyle(Color.brandColor(color: .text1))
        
        HStack(spacing: 16) {
            ForEach(Gender.sex,
                    id: \.self) { sex in
                Button {
                    viewStore.send(.sexSelectButtonTapped(sex))
                } label: {
                    Text(sex.rawValue)
                        .pretendard(.body3)
                        .foregroundStyle(viewStore.displayedSex == sex ?
                            .white :
                            Color.brandColor(color: .text2)
                        )
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(viewStore.displayedSex == sex ? Color.brandColor(color: .main) : .white)
                        
                }
//                .clipShape(Capsule())
            }
        }
    }
    
    //MARK: - heightAndWeightSectionBuilder
    
    /// 키와 몸무게를 수정할 수 있는 부분 뷰입니다.
    @ViewBuilder
    func heightAndWeightSectionBuilder() -> some View {
        HStack(spacing: 32) {
            // 키
            VStack(alignment: .leading) {
                Text("키")
                    .pretendard(.body2)
                    .foregroundStyle(Color.brandColor(color: .text1))
                
                /// FIXME: error control
                SCTextField(style: .line(),
                            placeHolder: constant.heightPlaceHolder.rawValue,
                            text: viewStore.$displayedWeight)
                .keyboardType(.numberPad)
            }
            
            // 몸무게
            VStack(alignment: .leading) {
                Text("몸무게")
                    .pretendard(.body2)
                    .foregroundStyle(Color.brandColor(color: .text1))
                
                /// - FIXME: error control
                SCTextField(style: .line(),
                            placeHolder: constant.heightPlaceHolder.rawValue,
                            text: viewStore.$displayedHeight)
                .keyboardType(.numberPad)
            }
        }
    }
}

//MARK: - Preview

#Preview {
    ProfileEditView(
        store: .init(initialState: .init(displayedSchool: "감자대학교"),
                     reducer: { ProfileEditFeature() }
        )
    )
}
