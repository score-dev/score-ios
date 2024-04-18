//
//  ContactView.swift
//  Score
//
//  Created by sole on 4/16/24.
//

import SwiftUI

//MARK: - ContactView

struct ContactView: View {
    let contexts = Contexts.Cantact.self
    @State var text: String = ""
    
    var body: some View {
        VStack(alignment: .leading,
               spacing: 12) {
            VStack(alignment: .leading,
                   spacing: 2) {
                Text(contexts.title.rawValue)
                    .pretendard(.body1)
                    .foregroundStyle(
                        Color.brandColor(color: .text1)
                    )
                
                Text(contexts.subTitle.rawValue)
                    .pretendard(.caption)
                    .foregroundStyle(
                        Color.brandColor(color: .text3)
                    )
            }
            
            SCTextField(style: .editor(lineLimit: 9),
                        placeHolder: contexts.textEditorPlaceHolder.rawValue,
                        text: .constant(""))
            Text("\(text.count) / 500자")
                .frame(maxWidth: .infinity,
                       alignment: .trailing)
                .pretendard(.caption)
                .foregroundStyle(
                    Color.brandColor(color: .text3)
                )
            
            Spacer()
            
            SCButton(style: .primary) {
                
            } label: {
                Text("의견 보내기")
                    .frame(maxWidth: .infinity)
            }
        }
        .layout()
        .scNavigationBar(style: .vertical) {
            DismissButton(style: .chevron) {
                
            }
            
            Text("문의하기")
        }
    }
}

//MARK: - Preview

#Preview {
    ContactView()
}
