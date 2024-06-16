//
//  SelectProfileImageView.swift
//  Score
//
//  Created by sole on 6/11/24.
//

import ComposableArchitecture
import SwiftUI

//MARK: - SelectProfileImageView

struct SelectProfileImageView: View {
    private let scoreCharacters = Constants.ImageName.ScoreCharacter.self
    
    private let columnLayout: [GridItem] = [
        .init(.flexible(minimum: 0,
                        maximum: .infinity),
              alignment: .center),
        .init(.flexible(minimum: 0,
                        maximum: .infinity),
              alignment: .center),
        .init(.flexible(minimum: 0,
                        maximum: .infinity),
              alignment: .center)
    ]
    
    private let store: StoreOf<TypeUserInfoFeature>
    @ObservedObject private var viewStore: ViewStoreOf<TypeUserInfoFeature>
    
    
    init(store: StoreOf<TypeUserInfoFeature>) {
        self.store = store
        self.viewStore = .init(store, observe: { $0 })
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            titleSectionBuilder()
            
            Spacer()
            
            photoPickerSectionBuilder()
            
            Spacer()
            
            scoreImageSectionBuilder()
        }
    }
    
    //MARK: - titleSectionBuilder
    
    private func titleSectionBuilder() -> some View {
        VStack(alignment: .leading,
               spacing: 4) {
            Text(Contexts.greeting.rawValue)
                .pretendard(.subHeading)
            
            Text(Contexts.title.rawValue)
                .pretendard(weight: .semiBold,
                            size: .xxl)
        }
    }
    
    //MARK: - photoPickerSectionBuilder
    
    @ViewBuilder
    private func photoPickerSectionBuilder() -> some View {
        PhotoPickerView(
            store: store.scope(
                state: \.photoPicker,
                action: \.photoPicker
            )
        ) {
            selectedImageSection()
                .overlay(alignment: .bottomTrailing) {
                    SCIcon(
                        style: .init(
                            size: .custom(size: 35,
                                          imageScale: 20),
                            color: .gray3
                        ),
                        imageName: .camera
                    )
                }
        }
        .frame(maxWidth: .infinity)
    }
    
    //MARK: - scoreImageSectionBuilder
    
    @ViewBuilder
    private func scoreImageSectionBuilder() -> some View {
        VStack(alignment: .leading,
               spacing: 20) {
            Text(Contexts.scoreImageGuide.rawValue)
                .fixedSize(horizontal: false,
                           vertical: true)
                .pretendard(.subHeading)
                
            
            LazyVGrid(columns: self.columnLayout,
                      spacing: 20) {
                ForEach(scoreCharacters.allCases,
                        id: \.self) { character in
                    Button {
                        store.send(.tappedScoreImage(character))
                    } label: {
                        character.image()
                            .rectFrame(size: 94)
                            .background(
                                character.backgroundColor,
                                in: Circle()
                            )
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func selectedImageSection() -> some View {
        if viewStore.selectedScoreCharacter != nil {
            viewStore.selectedScoreCharacter?.image()
                .rectFrame(size: 116)
                .background(
                    viewStore.selectedScoreCharacter!.backgroundColor,
                    in: Circle()
                )
        } else {
            viewStore.profileImage
                .imagePlaceHolder(size: 116)
        }
    }
    
    //MARK: - Contexts
    
    private enum Contexts: String {
        case title =
        """
        사용할 사진을 골라주세요
        """
        case greeting =
        """
        처음 방문하셨군요! 환영해요:)
        """
        case scoreImageGuide =
        """
        마음에 드는 사진이 없나요?
        그럼 아래 캐릭터 중에 하나를 골라보세요!
        """
    }
}

//MARK: - Preview

#Preview {
    SelectProfileImageView(
        store: .init(initialState: .init(),
                     reducer: { TypeUserInfoFeature() }
                    )
    )
    .layout()
}
