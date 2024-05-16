//
//  MyPageMainFeature.swift
//  Score
//
//  Created by sole on 4/24/24.
//

import ComposableArchitecture

//MARK: - MyPageMainFeature

@Reducer
struct MyPageMainFeature {
    @Dependency(\.dismiss) var dismiss
    typealias Tab = MyPageLineTab
    
    //MARK: - MyPageLineTab
    
    enum MyPageLineTab: SCLineTabProtocol {
        case feed
        case calendar
    }
    
    //MARK: - State
    
    struct State: Equatable {
        @PresentationState var destination: Destination.State?
        
        var lineTabBar: SCLineTabBarFeature<Tab>.State = .init(
            tabItems: [.init(title: "피드", tab: .feed),
                       .init(title: "캘린더", tab: .calendar)],
            selectedTab: .feed)
        
        var calendar: CalendarFeature.State = .init()
        var feed: FeedMainFeature.State = .init()
    }
    
    //MARK: - State
    
    enum Action {
        case viewApearing
        case tasking
        
        case dismissButtonTapped
        case settingButtonTapped
        case profileEditButtonTapped
        case myFriendButtonTapped
        
        case destination(PresentationAction<Destination.Action>)
        case lineTabBar(SCLineTabBarFeature<Tab>.Action)
        case calendar(CalendarFeature.Action)
        case feed(FeedMainFeature.Action)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewApearing:
                return .none
                
            case .tasking:
                return .none
                
            case .dismissButtonTapped:
                return .run { send in
                    await self.dismiss()
                }
                
            case .settingButtonTapped:
                state.destination = .setting(.init())
                return .none
                
            case .profileEditButtonTapped:
                state.destination = .profileEdit(.init())
                return .none
                
            case .myFriendButtonTapped:
                return .none
                
            case .destination,
                    .lineTabBar,
                    .calendar,
                    .feed:
                return .none
            }
        }
        .ifLet(\.$destination,
                action: \.destination) {
            Destination()
        }
        
        Scope(state: \.lineTabBar,
              action: \.lineTabBar) {
            SCLineTabBarFeature()
        }
        
        Scope(state: \.calendar,
              action: \.calendar) {
            CalendarFeature()
        }
        
        Scope(state: \.feed,
              action: \.feed) {
            FeedMainFeature()
        }
    }
    
    //MARK: - Destination
    
    @Reducer
    struct Destination {
        enum State: Equatable {
            case setting(SettingMainFeature.State)
            case profileEdit(ProfileEditFeature.State)
        }
        
        enum Action {
            case setting(SettingMainFeature.Action)
            case profileEdit(ProfileEditFeature.Action)
        }
        
        var body: some ReducerOf<Self> {
            Scope(state: \.setting,
                  action: \.setting) {
                SettingMainFeature()
            }
            
            Scope(state: \.profileEdit,
                  action: \.profileEdit) {
                ProfileEditFeature()
            }
            
        }
    }
}
