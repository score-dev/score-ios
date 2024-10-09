//
//  AppleAuthStore.swift
//  Score
//
//  Created by sole on 5/23/24.
//
import ComposableArchitecture
import AuthenticationServices
import Foundation

class AppleAuthStore: NSObject,
                      ASAuthorizationControllerDelegate {
    static let shared: AppleAuthStore = .init()
    private let authorizationController: ASAuthorizationController
    private let store: StoreOf<AppleAuthFeature>
    private let appleIDProvider: ASAuthorizationAppleIDProvider
    //MARK: - init
    private override init() {
        self.appleIDProvider = .init()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.email, .fullName]
        
//        let passwordProvider = ASAuthorizationPasswordProvider()
//        let passwordRequest = passwordProvider.createRequest()
        
        self.authorizationController = .init(authorizationRequests: [request])
        
        self.store = .init(initialState: .init(),
                                    reducer: { AppleAuthFeature() })
        
        super.init()
        authorizationController.delegate = self
    }
    
    
    func auth() {
        self.appleIDProvider.getCredentialState(forUserID: "") { credentialState, error in
            if let error {
                
                return
            }
            
            switch credentialState {
            case .revoked:
                print("revoked")
                break
            case .authorized:
                print("authorized")
                break
            case .notFound:
                print("notFound")
                break
            case .transferred:
                print("transferred")
                break
            @unknown default:
                break
            }
            
        }
    }
    
    //MARK: - signIn
    
    /// 애플 로그인 메서드입니다.
    /// email, fullName을 받습니다.
    func signIn() {
        authorizationController.performRequests()
    }
    
    //MARK: - signOut
    
    /// 로그아웃입니다.
    func signOut() {
       
    }
    
    //MARK: - authorizationController(controller:didCompleteWithAuthorization:)
    
    /// 애플 로그인 완료 시 실행되는 메서드입니다.
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential
        else { return }
        
        self.store.send(.didCompleteWithAuthorization(appleIDCredential))
//        switch authorization.credential {
//        case let appleIDCredential as ASAuthorizationAppleIDCredential:
//            self.store.send(.didCompleteWithAuthorization(appleIDCredential))
//        default:
//            break
//        }
    }
    
    //MARK: - authorizationController(controller:didCompleteWithError:)
    
    /// 애플 로그인 시 에러가 발생했을 때 실행되는 메서드입니다.
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: any Error
    ) {
        self.store.send(.didCompleteWithError(error))
    }
}
