//
//  AddNewGroupView.swift
//  Score
//
//  Created by sole on 8/24/24.
//

import ComposableArchitecture
import SwiftUI

struct AddNewGroupView: View {
     private let store: StoreOf<AddNewGroupFeature>
     @ObservedObject var viewStore: ViewStoreOf<AddNewGroupFeature>
    
    init(store: StoreOf<AddNewGroupFeature>) {
        self.store = store
        self.viewStore = .init(store,
                               observe: { $0 })
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading,
                   spacing: 20) {
                photoPickerSectionBuilder()
                
                VStack(alignment: .leading,
                       spacing: 24) {
                    typeGroupInfoSectionBuilder()
                    
                    selectMaxGroupCountSectionBuilder()
                    
                    selectGroupPublicOptionSectionBuilder()
                }
                .padding(.bottom, 30)
                
                SCButton(style: .primary) {
                     store.send(.tappedGroupGenerateButton)
                } label: {
                    Text("생성하기")
                        .frame(maxWidth: .infinity)
                }
                .buttonDisabled(viewStore.isDisabledGenterateButton)
            }
            .padding(.bottom, 20)
            .layout()
        }
        .onTapGesture {
            hideKeyboard()
        }
        .scNavigationBar {
            Text("그룹 생성하기")
            
            Spacer()
            
            DismissButton(style: .close) {
                 store.send(.tappedDismissButton)
            }
        }
        .sheet(isPresented: viewStore.$isPresentingMaxCountPickerSheet) {
            pickerSheetBuilder()
                .presentationDetents([.fraction(0.3)])
        }
    }
    
    @ViewBuilder
    private func photoPickerSectionBuilder() -> some View {
        PhotoPickerView(
            store: store.scope(
                state: \.photoPicker,
                action: \.photoPicker
            )
        ) {
            Color.brandColor(color: .gray2)
                .frame(height: 220)
                .frame(maxWidth: .infinity)
                .overlay {
                    Text("우리 그룹을\n표현할 이미지를 올려주세요")
                        .multilineTextAlignment(.center)
                        .pretendard(.body2)
                        .foregroundStyle(
                            Color.brandColor(color: .text2)
                        )
                        .padding(.vertical, 77)
                        .padding(.horizontal, 71)
                    
                    if let groupImage = viewStore.groupImage {
                        groupImage
                            .resizable()
                    }
                }
                .overlay {
                    if let groupImage = viewStore.groupImage {
                        groupImage
                            .resizable()
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
    
    @ViewBuilder
    private func typeGroupInfoSectionBuilder() -> some View {
        VStack(alignment: .leading,
               spacing: 24) {
            VStack(alignment: .leading,
                   spacing: 12) {
                HStack(alignment: .bottom,
                       spacing: 0) {
                    Text("그룹명")
                        .pretendard(.body1)
                        .foregroundStyle(Color.brandColor(color: .text1))
                    
                    Text("*")
                        .pretendard(.body1)
                        .foregroundStyle(Color.brandColor(color: .red))
                    
                    Spacer()
                    
                    Text("\(viewStore.groupName.count)/\(viewStore.maxGroupNameCount)")
                        .pretendard(.caption)
                        .foregroundStyle(Color.brandColor(color: .text3))
                }
                       .pretendard(.body1)
                
                
                SCTextField(style: .plain(error: nil),
                            placeHolder: "우리 그룹 이름은 무엇으로 해볼까요?",
                            text: viewStore.$groupName)
            }
            
            VStack(alignment: .leading,
                   spacing: 12) {
                HStack(alignment: .bottom,
                       spacing: 0) {
                    Text("그룹 소개")
                        .pretendard(.body1)
                        .foregroundStyle(Color.brandColor(color: .text1))
                    
                    Spacer()
                    
                    Text("\(viewStore.groupDescription.count)/\(viewStore.maxGroupDescriptionCount)")
                        .pretendard(.caption)
                        .foregroundStyle(Color.brandColor(color: .text3))
                }
                       .pretendard(.body1)
                
                
                SCTextField(style: .editor(lineLimit: 10),
                            placeHolder: "우리 그룹을 자유롭게 소개해보세요!",
                            text: viewStore.$groupDescription)
            }
        }
    }
    
    @ViewBuilder
    private func selectMaxGroupCountSectionBuilder() -> some View {
        VStack(alignment: .leading,
               spacing: 12) {
            AttributedText {
                Text("최대 인원 제한")
                    .pretendard(.body1)
                    .foregroundStyle(Color.brandColor(color: .text1))
                
                Text("*")
                    .pretendard(.body1)
                    .foregroundStyle(Color.brandColor(color: .red))
            }
            
            Button {
                store.send(.tappedMaxGroupCountPickerButton)
            } label: {
                Text(viewStore.groupMaxCount == nil ? "그룹 최대 인원" : "\(viewStore.groupMaxCount!)명")
                    .foregroundStyle(Color.brandColor(color: .text3))
                    .padding(.vertical, 18)
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 14)
                            .strokeBorder(style: .init(lineWidth: 1))
                            .foregroundStyle(Color.brandColor(color: .gray3))
                    }
            }
        }
    }
    
    @ViewBuilder
    private func pickerSheetBuilder() -> some View {
        Picker(selection: viewStore.$groupMaxCount) {
            ForEach(1..<5) { count in
                Text("\(count)명")
                    .tag(count)
            }
        } label: {}
        .pickerStyle(.wheel)
    }
    
    @ViewBuilder
    private func selectGroupPublicOptionSectionBuilder() -> some View {
        VStack(alignment: .leading,
               spacing: 12) {
            AttributedText {
                Text("최대 인원 제한")
                    .pretendard(.body1)
                    .foregroundStyle(Color.brandColor(color: .text1))
                
                Text("*")
                    .pretendard(.body1)
                    .foregroundStyle(Color.brandColor(color: .red))
            }
            
            HStack {
                Text("공개")
                    .pretendard(.body2)
                    .foregroundStyle(Color.brandColor(color: .text1))
                
                Spacer()
                
                SCRadioButton(isOn: viewStore.$isPublicGroup)
            }
            
            HStack {
                Text("비공개")
                    .pretendard(.body2)
                    .foregroundStyle(Color.brandColor(color: .text1))
                
                Spacer()
                
                SCRadioButton(isOn: viewStore.$isPrivateGroup)
            }
            
            if viewStore.isPrivateGroup {
                SCTextField(style: .plain(error: nil),
                            placeHolder: "그룹 비밀번호 4자리를 입력해주세요",
                            text: viewStore.$privateGroupPassword)
                .keyboardType(.numberPad)
            }
        }
    }
}

#Preview {
    AddNewGroupView(store: .init(initialState: .init(), reducer: { AddNewGroupFeature() }))
}
