//
//  SettingMainView.swift
//  Score
//
//  Created by sole on 4/16/24.
//

import ComposableArchitecture
import SwiftUI

//MARK: - SettingMainView

struct SettingMainView: View {
    private let navigationDestinations = Navigation.Main.self
    
    let store: StoreOf<SettingMainFeature>
    @ObservedObject var viewStore: ViewStoreOf<SettingMainFeature>
    
    init(store: StoreOf<SettingMainFeature>) {
        self.store = store
        viewStore = .init(store,
                          observe: { $0 })
    }
    
    //MARK: - body
    
    var body: some View {
        self.core
            .navigationDestinationBuilder(store: store)
    }
    
    //MARK: - core
    
    var core: some View {
        VStack(alignment: .leading,
               spacing: 0) {
            ForEach(navigationDestinations.allCases,
                    id: \.self) { destination in
                Button {
                    viewStore.send(.navigationButtonTapped(destination))
                } label: {
                    Text(destination.rawValue)
                        .settingRowModifier()
                }
            }
            Spacer()
        }
        .layout()
        .scNavigationBar(style: .vertical) {
            DismissButton(style: .chevron) {
                viewStore.send(.dismissButtonTapped)
            }
            
            Text("환경설정")
        }
        .scPopUp(style: .dialog,
                 isPresented: viewStore.$isPresentedSignOutDialog) {
            SignOutPopUp(viewStore: viewStore)
        }
    }
}

//MARK: - View+navigationDestinationBuilder

///            The compiler is unable to type-check this expression in reasonable time; try breaking up the expression into distinct sub-expressions
///            많은 navigationDestination 호출 시 발생하는 type check 에러 해결을 위해 navigationDestinationBuilder로 navigationDestination 단락을 따로 뺍니다.
extension View {
    @ViewBuilder
    func navigationDestinationBuilder(
        store: StoreOf<SettingMainFeature>
    ) -> some View {
        self
            .navigationDestination(
                store: store.scope(
                    state: \.$destination.alarmSetting,
                    action: \.destination.alarmSetting
                )
            ) { store in
                AlarmSettingView(store: store)
            }
            .navigationDestination(
                store: store.scope(
                    state: \.$destination.blockUserSetting,
                    action: \.destination.blockUserSetting
                )
            ) { store in
                BlockUserSettingView(store: store)
            }
            .navigationDestination(
                store: store.scope(
                    state: \.$destination.policy,
                    action: \.destination.policy
                )
            ) { store in
                PolicyView(store: store)
            }
            .navigationDestination(
                store: store.scope(
                    state: \.$destination.unregister,
                    action: \.destination.unregister
                )
            ) { store in
                UnregisterView(store: store)
            }
            .sheet(
                store: store.scope(
                    state: \.$destination.contact,
                    action: \.destination.contact
                )
            ) { store in
                ContactView(store: store)
            }
    }
}

//MARK: - Preview

#Preview {
    NavigationStack {
        SettingMainView(store: .init(initialState: .init(),
                                     reducer: { SettingMainFeature() }))
    }
}
