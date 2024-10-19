//
//  GoogleAuthStore.swift
//  Score
//
//  Created by sole on 5/31/24.
//

import GoogleSignIn
import UIKit

class GoogleAuthStore {
    static let shared: GoogleAuthStore = .init()
    
    private init() {}
    
    func auth() async throws {
        if let user = GIDSignIn.sharedInstance.currentUser {
            let user = try await GIDSignIn.sharedInstance.restorePreviousSignIn()
            print("restore")
            print(user.userID)
        } else {
            print("sign IN")
            let result = try await self.signIn()
            print(result.description)
        }
    }
    
    @MainActor
    func signIn() async throws -> GIDSignInResult {
        guard let rootViewController = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .filter({ $0.activationState == .foregroundActive })
            .first?.keyWindow?.rootViewController
        else { throw SCError() }
        
        let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
       
        // result 반환 필요
        return result
    }
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
    }
}
