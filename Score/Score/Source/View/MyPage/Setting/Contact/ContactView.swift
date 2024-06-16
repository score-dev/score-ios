//
//  ContactView.swift
//  Score
//
//  Created by sole on 4/16/24.
//

import ComposableArchitecture
import MessageUI
import SwiftUI

//MARK: - ContactView

struct ContactView: View {
    let store: StoreOf<ContactFeature>
    @ObservedObject var viewStore: ViewStoreOf<ContactFeature>
    
    init(store: StoreOf<ContactFeature>) {
        self.store = store
        self.viewStore = ViewStore(store,
                                   observe: { $0 })
    }
    
    //MARK: - body
    
    var body: some View {
        self.core
            .onAppear{
                viewStore.send(.viewAppearing)
            }
    }
    
    //MARK: - core
    
    @ViewBuilder
    var core: some View {
        if viewStore.isAbleToUseMessage {
            MailView(store: store)
        } else {
            EmailGuideSheet(store: store)
                .presentationDetents([.medium])
        }
    }
}

//MARK: - MailView

struct MailView: UIViewControllerRepresentable {
    private let contexts = Contexts.Cantact.self
    let store: StoreOf<ContactFeature>
    @ObservedObject var viewStore: ViewStoreOf<ContactFeature>
    
    init(store: StoreOf<ContactFeature>) {
        self.store = store
        self.viewStore = ViewStore(store,
                                   observe: { $0 })
    }
    
    func makeUIViewController(
        context: Context
    ) -> some MFMailComposeViewController {
        let mfMailVC = MFMailComposeViewController()
        mfMailVC.mailComposeDelegate = context.coordinator
        
        // 메일 발송지 설정
        mfMailVC.setToRecipients([contexts.recipient.rawValue])
        // 제목 설정
        mfMailVC.setSubject(contexts.subject.rawValue)
        // 본문 설정
        mfMailVC.setMessageBody(contexts.messageBody.rawValue,
                                isHTML: false)
        
        return mfMailVC
    }
    
    
    func updateUIViewController(
        _ uiViewController: UIViewControllerType,
        context: Context
    ) {
        
    }
    
    func makeCoordinator() -> MailCoordinator {
        Coordinator(self)
    }
    
    //MARK: - MailCoordinator
    
    final class MailCoordinator: NSObject,
                       MFMailComposeViewControllerDelegate,
                       UINavigationControllerDelegate {
        let parent: MailView
        
        init(_ mailView: MailView) {
            self.parent = mailView
        }
        
        //MARK: - mailComposeController
        
        func mailComposeController(
            _ controller: MFMailComposeViewController,
            didFinishWith result: MFMailComposeResult,
            error: (any Error)?
        ) {
            parent.viewStore.send(.didFinishToSendMail(result))
        }
    }
}

//MARK: - Preview
//
#Preview {
    ContactView(store: .init(initialState: .init(),
                             reducer: { ContactFeature() }))
}
