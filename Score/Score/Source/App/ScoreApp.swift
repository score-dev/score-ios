//
//  ScoreApp.swift
//  Score
//
//  Created by sole on 3/19/24.
//

import SwiftUI
import KakaoSDKAuth
import KakaoSDKCommon

@main
struct ScoreApp: App {
    @UIApplicationDelegateAdaptor var delegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                TabRouteView(store: .init(initialState: .init(),
                                          reducer: { SCTabBarFeature() }))
            }
        }
    }
}
