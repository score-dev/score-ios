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
    let constant = Contexts.MyPage.self
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ScrollView {
                VStack(alignment: .leading,
                       spacing: 28) {
                    // navigation header 추가
                    
                    profileImageSection(viewStore: viewStore)
                    
                    nickNameSection(viewStore: viewStore)
                    
                    workOutAlarmTimeSection(viewStore: viewStore)
                    
                    schoolSection(viewStore: viewStore)
                    
                    gradeSection(viewStore: viewStore)
                    
                    sexSelectSection(viewStore: viewStore)
                    
                    heightAndWeightSection(viewStore: viewStore)
                    
                    SCButton(style: .primary) {
                        viewStore.send(.editDoneButtonTapped)
                    } label: {
                        Text("저장하기")
                            .frame(maxWidth: .infinity)
                    }
                }
                 .layout()
            }
        }
    }
    
    //MARK: - profileImageSection
    
    /// 프로필 이미지를 수정할 수 있는 부분 뷰입니다.
    @ViewBuilder
    func profileImageSection(
        viewStore: ViewStoreOf<ProfileEditFeature>
    ) -> some View {
        if let image = viewStore.displayedProfileImage {
            image
                .resizable()
                .frame(width: 130,
                       height: 130)
                .background(Color.brandColor(color: .gray2))
                .clipShape(Circle())
                .overlay(alignment: .bottomTrailing) {
                    PhotoPickerView(viewStore: viewStore) {
                        SCIcon(
                            style: .init(
                                size: .medium,
                                color: .gray3
                            ),
                            imageName: .pencil)
                    }
                }
                .frame(maxWidth: .infinity)
        } else {
            // image PlaceHolder
            Circle()
                .frame(width: 130,
                       height: 130)
            // - FIXME: Color 변경
                .foregroundStyle(
                    Color.brandColor(color: .gray1)
                )
                .overlay(alignment: .bottomTrailing) {
                    PhotoPickerView(viewStore: viewStore) {
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
    }
    
    //MARK: - nickNameSection
    
    /// 닉네임을 수정할 수 있는 부분 뷰입니다.
    @MainActor
    @ViewBuilder
    func nickNameSection(
        viewStore: ViewStoreOf<ProfileEditFeature>
    ) -> some View {
        Text("닉네임")
            .pretendard(.body2)
            .foregroundStyle(
                Color.brandColor(color: .text1)
            )
        
        SCTextField(style: .line(),
                    placeHolder: constant.nickNamePlaceHolder.rawValue,
                    text: viewStore.$displayedNickName)
    }
    
    //MARK: - workOutAlarmTimeSection
    
    /// 알람 시간을 수정할 수 있는 부분 뷰입니다.
    @ViewBuilder
    func workOutAlarmTimeSection(
        viewStore: ViewStoreOf<ProfileEditFeature>
    ) -> some View {
        Text("운동 알람 시간")
            .pretendard(.body2)
            .foregroundStyle(Color.brandColor(color: .text1))
        
        SCButton(style: .gray) {
            
        } label: {
            Text("매일 오전 00:00")
                .pretendard(.body1)
                .foregroundStyle(Color.brandColor(color: .text1))
                .frame(maxWidth: .infinity)
        }
    }
    
    //MARK: - schoolSection
    
    /// 학교를 수정할 수 있는 부분 뷰입니다.
    @ViewBuilder
    func schoolSection(
        viewStore: ViewStoreOf<ProfileEditFeature>
    ) -> some View {
        Text("학교")
            .pretendard(.body2)
            .foregroundStyle(Color.brandColor(color: .text1))
        
        SCButton(style: .gray) {
            viewStore.send(.schoolEditButtonTapped)
        } label: {
            Text("학교")
                .foregroundStyle(Color.brandColor(color: .text1))
                .frame(maxWidth: .infinity)
        }
    }
    
    //MARK: - gradeSection
    
    /// 학년을 수정할 수 있는 부분 뷰입니다.
    @ViewBuilder
    func gradeSection(
        viewStore: ViewStoreOf<ProfileEditFeature>
    ) -> some View {
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
    
    //MARK: - sexSelectSection
    
    /// 성별을 수정할 수 있는 부분 뷰입니다.
    @ViewBuilder
    func sexSelectSection(
        viewStore: ViewStoreOf<ProfileEditFeature>
    ) -> some View {
        Text("성별")
            .pretendard(.body2)
            .foregroundStyle(Color.brandColor(color: .text1))
        
        HStack(spacing: 16) {
            SCButton(
                style: viewStore.displayedSex == .male ?
                    .primary : .teritary) {
                        viewStore.send(.sexSelectButtonTapped(.male))
                    } label: {
                        Text("남")
                            .frame(maxWidth: .infinity)
                    }
                    .clipShape(Capsule())
            
            SCButton(
                style: viewStore.displayedSex == .female ?
                    .primary : .teritary) {
                        viewStore.send(.sexSelectButtonTapped(.female))
                    } label: {
                        Text("여")
                            .frame(maxWidth: .infinity)
                    }
                    .clipShape(Capsule())
        }
    }
    
    //MARK: - heightAndWeightSection
    
    /// 키와 몸무게를 수정할 수 있는 부분 뷰입니다.
    @MainActor
    @ViewBuilder
    func heightAndWeightSection(
        viewStore: ViewStoreOf<ProfileEditFeature>
    ) -> some View {
        HStack(spacing: 32) {
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
        store: .init(initialState: ProfileEditFeature.State(
            displayedNickName: "",
            displayedHeight: "",
            displayedWeight: "",
            displayedSex: .female,
            displayedSchool: "감자",
            displayedGrade: 1,
            isPresentingEditGradeSheet: false,
            isPresentingEditSchoolSheet: false
        ),
                     reducer: { ProfileEditFeature() }
        )
    )
}
