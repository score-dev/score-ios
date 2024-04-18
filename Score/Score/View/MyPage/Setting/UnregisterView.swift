//
//  UnregisterView.swift
//  Score
//
//  Created by sole on 4/16/24.
//

import SwiftUI

//MARK: - UnregisterView

struct UnregisterView: View {
    private let contexts = Contexts.Unregister.self
    private let imageNames = Constants.ImageName.self
    
    @State var isDisabled: Bool = false
    @State var text: String = ""
    
    var body: some View {
        VStack(alignment: .leading,
               spacing: 40) {
            
            VStack(alignment: .leading,
                   spacing: 4) {
                Text(contexts.title.rawValue)
                    .pretendard(weight: .semiBold,
                                size: .xxl)
                
                Text(contexts.subTitle.rawValue)
                    .pretendard(.subHeading)
            }
            
            VStack(spacing: 24) {
                ForEach(UnregisterReason.allCases, id: \.self) { reason in
                    SCButton(style: .gray) {
                        //select
                    } label: {
                        Text(reason.rawValue)
                            .frame(maxWidth: .infinity)
                    }
                }
                
                // FIXME: text state 적용
                SCTextField(
                    style: .plain(),
                    placeHolder: contexts.textFieldPlaceHolder.rawValue,
                    text: $text)
                .scButtonItem {
                    
                } label: {
                    Image(imageNames.closeCircle.rawValue)
                }
            }
            
            Spacer()
            
            SCButton(style: .primary) {
                
            } label: {
                Text("탈퇴하기")
                    .frame(maxWidth: .infinity)
            }
            .buttonDisabled(isDisabled)
        }
        .layout()
        .scNavigationBar(style: .vertical) {
            DismissButton(style: .chevron) {
                
            }
            
            Text("탈퇴하기")
        }
        
    }
}

//MARK: - UnregisterReason

enum UnregisterReason: String,
                       CaseIterable {
    case notAsExpected = "기대했던 앱이 아니에요"
    case tooComplex = "이용이 번거롭고 불편해요"
    case tooManyErrors = "오류가 너무 많아요"
    case friendsNotUsing = "친구들이 사용을 안해요"
}

//MARK: - Preview

#Preview {
    UnregisterView()
}
