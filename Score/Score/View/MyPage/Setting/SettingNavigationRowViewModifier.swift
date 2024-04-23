//
//  NavigationRowViewModifier.swift
//  Score
//
//  Created by sole on 4/21/24.
//

import SwiftUI

//MARK: - NavigationRow

struct NavigationRowViewModifier: ViewModifier {
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

//MARK: - View+NavigationRowViewModifier

extension View {
    @ViewBuilder
    func settingRowModifier() -> some View {
        modifier(NavigationRowViewModifier())
    }
}
