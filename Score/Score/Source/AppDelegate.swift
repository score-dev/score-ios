//
//  AppDelegate.swift
//  Score
//
//  Created by sole on 5/28/24.
//

import Foundation
import GoogleSignIn
import KakaoSDKAuth
import KakaoSDKCommon
import NMapsMap

//MARK: - AppDelegate

class AppDelegate: NSObject,
                   UIApplicationDelegate {
    private let apiKeys = Constants.APIKey.self
    
    //MARK: - application(:didFinishLaunchingWithOptions:)
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {        
        // KakaoSDK 초기화
        KakaoSDK.initSDK(
            appKey: self.apiKeys.Kakao.appID.getValueFromBundle() ?? "none"
        )
            
        // Google Client ID 초기화
        GIDSignIn.sharedInstance.configuration = .init(
            clientID: self.apiKeys.Google.clientID.getValueFromBundle() ?? "none"
        )
        
        // Naver Client ID 지정
        NMFAuthManager.shared().clientId = self.apiKeys.Naver.clientID.getValueFromBundle() ?? "none"
        
        return false
    }
    
    //MARK: - application(:open:options:)
    
    func application(
      _ app: UIApplication,
      open url: URL,
      options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}
