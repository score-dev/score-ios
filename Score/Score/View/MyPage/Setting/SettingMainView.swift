//
//  SettingMainView.swift
//  Score
//
//  Created by sole on 4/16/24.
//

import SwiftUI

//MARK: - SettingMainView.swift

struct SettingMainView: View {
    private let navigationLabels = SettingNavigation.Main.self
    
    var body: some View {
        VStack(alignment: .leading,
               spacing: 0) {
            ForEach(navigationLabels.allCases,
                    id: \.self) { settingLabel in
                Button {
                    // navigate to detail view
                } label: {
                    Text(settingLabel.rawValue)
                        .settingRowModifier()
                }
            }
            Spacer()
        }
        .layout()
        .scNavigationBar(style: .vertical) {
            DismissButton(style: .chevron) {
               // dismiss this view
            }
            
            Text("환경설정")
        }
        
    }
}

//MARK: - SettingNavigationRow

struct SettingNavigationRowViewModifier: ViewModifier {
    let imageNames = Constants.ImageName.self
    
    func body(content: Content) -> some View {
        HStack {
            content
                .pretendard(.body2)
                .foregroundStyle(
                    Color.brandColor(color: .text1)
                )
            Spacer()
            
            Image(imageNames.chevronRight.rawValue)
                .frame(width: 24,
                       height: 24)
        }
        .padding(.vertical, 16)
    }
}

//MARK: - View+SettingNavigationRowViewModifier

extension View {
    @ViewBuilder
    func settingRowModifier() -> some View {
        modifier(SettingNavigationRowViewModifier())
    }
}



//MARK: - Preview

#Preview {
    SettingMainView()
}
