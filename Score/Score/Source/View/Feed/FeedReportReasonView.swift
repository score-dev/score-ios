//
//  FeedReportReasonView.swift
//  Score
//
//  Created by sole on 8/26/24.
//

import SwiftUI

struct FeedReportReasonView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading,
                   spacing: 36) {
                Text("신고하려는 이유를 알려주세요")
                    .pretendard(weight: .semiBold,
                                size: .xxl)
                    .foregroundStyle(
                        Color.brandColor(color: .text1)
                    )
                
                VStack(spacing: 20) {
                    ForEach(ReportReason.allCases,
                            id: \.self) { reason in
                        SCButton(style: .gray) {
                            
                        } label: {
                            Text(reason.rawValue)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    
                    SCTextField(style: .plain(error: nil),
                                placeHolder: "기타(신고 사유를 입력해주세요)",
                                text: .constant(""))
                }
                .padding(.bottom, 4)
                
                SCButton(style: .primary) {
                    
                } label: {
                    Text("신고하기")
                        .frame(maxWidth: .infinity)
                }
                .padding(.bottom, 20)
            }
            .layout()
        }
        .scNavigationBar {
            DismissButton(style: .chevron) {
                // store.send(.tappedDismissButton)
            }
            
            Text("피드 신고하기")
            
            Spacer()
        }
    }
    
    enum ReportReason: String, CaseIterable {
        case sensitiveContent = "민감한 글이나 사진을 보여주고 있습니다."
        case harmfulOrAbusiveContent = "가학적이거나 유해한 내용입니다."
        case illegalDistribution = "불법 촬영물 등을 유통하고 있습니다."
        case offensiveLanguage = "욕설, 비하, 혐오 발언이 있습니다."
        case commercialAdvertisement = "상업적 광고 및 판매의 내용이 있습니다."
        case userDislike = "마음에 들지 않습니다."
    }
}

#Preview {
    FeedReportReasonView()
}
