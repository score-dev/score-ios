//
//  SCLoading.swift
//  Score
//
//  Created by sole on 5/21/24.
//

import SwiftUI
//MARK: - SCLoading

// FIXME: 디자인 수정 필요
struct SCLoading: View {
    var body: some View {
        // 임시 progress view
        ProgressView()
    }
}

//MARK: - View+onLoading

extension View {
    @ViewBuilder
    func onLoading(
        _ isLoading: Bool
    ) -> some View {
        if isLoading {
            self
                .disabled(true)
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity)
                .overlay {
                    SCLoading()
                        .padding(.vertical, 20)
                        .padding(.horizontal, 20)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(Color.brandColor(color: .gray3))
                                .opacity(0.98)
                        }
                }
        } else {
            self
        }
    }
}

//MARK: - Preview

#Preview {
    VStack {
        Text("1")
    }
    .onLoading(true)
}
