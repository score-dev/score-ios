//
//  FeedDTO.swift
//  Score
//
//  Created by sole on 10/10/24.
//

struct ReportFeedDTO: Encodable {
    let agentId: Int64
    let feedId: Int64
    let reportReason: String
    let comment: String
}
