//
//  Notification.swift
//  Score
//
//  Created by sole on 10/10/24.
//

struct PostFCMToken: Encodable {
    let token: String 
}

struct FCMRequest: Encodable {
    let userId: Int64
    let title: String
    let body: String
}
