//
//  SCSearchChip.swift
//  Score
//
//  Created by sole on 4/3/24.
//

import SwiftUI

//MARK: - SCSearchChip

/// 검색어 기록 Chip입니다.
/// - Parameters:
///     - text: 저장될 검색어를 정의합니다.
///     - action: chip을 탭했을 때 일어날 동작을 정의합니다.
///     - dismiss: close 버튼을 탭했을 때 일어날 동작을 정의합니다.
struct SCSearchChip: View {
    let text: String
    let action: () -> (Void)
    let dismiss: () -> (Void)
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Text(text)
                    .pretendard(.body2)
                    .foregroundStyle(Color.brandColor(color: .text2))
                
                Button(action: dismiss) {
                    Image(Constants.ImageName.close.rawValue)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.brandColor(color: .icon))
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 19)
            .background(Color.brandColor(color: .gray2),
                        in: RoundedRectangle(cornerRadius: 25.5))
        }
    }
}

//MARK: - Preview

#Preview {
    SCSearchChip(text: "12312324342343") {
        
    } dismiss: {
        
    }
}
