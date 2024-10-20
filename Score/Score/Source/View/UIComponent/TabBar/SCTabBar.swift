//
//  SCTabBar.swift
//  Score
//
//  Created by sole on 4/2/24.
//

import ComposableArchitecture
import SwiftUI

//MARK: - SCTabBarButtonStyle

enum SCTabBarButtonStyle {
    case plain(item: SCTabItem)
    case floating(item: SCTabItem)
}

//MARK: - SCTabItem

enum SCTabItem: String,
                CaseIterable,
                Hashable {
    case home = "홈"
    case record = "기록하기"
    case schoolGroup = "학교 그룹"
    
    func imageName() -> String {
        let constant = Constants.ImageName.self
        switch self {
        case .home:
            return constant.home.rawValue
        case .record:
            return constant.footsteps.rawValue
        case .schoolGroup:
            return constant.navigationUsers.rawValue
        }
    }
}

//MARK: - SCTabBar

/// - Parameters:
///     - store: SCTabBarFeature Reducer를 정의합니다.
struct SCTabBar: View {
    let store: StoreOf<SCTabBarFeature>
    @ObservedObject var viewStore: ViewStoreOf<SCTabBarFeature>
    
    init(store: StoreOf<SCTabBarFeature>) {
        self.store = store
        self.viewStore = ViewStore(store,
                                   observe: { $0 })
    }
    
    var body: some View {
            HStack(spacing: 54) {
                tabButtonBuilder(.plain(item: .home)) {
                    store.send(.tabItemButtonTapped(.home))
                }
                
                tabButtonBuilder(.floating(item: .record)) {
                    store.send(.tabItemButtonTapped(.record))
                }
                
                tabButtonBuilder(.plain(item: .schoolGroup)) {
                    store.send(.tabItemButtonTapped(.schoolGroup))
                }
            }
            .frame(maxWidth: .infinity)
            .background {
                Rectangle()
                    .foregroundStyle(Color.white)
                    .edgeBorder(lineWidth: 0.5,
                                edges: [.top],
                                color: Color.brandColor(
                                    color: .gray3
                                )
                    )
                    .offset(y: 30)
            }
            .frame(height: 56)
            // - FIXME: SE 기기 대응 필요
            .padding(.bottom, 15)
    }
    
    //MARK: - tabButtonBuilder
    
    /// - Parameters:
    ///     - style: 탭바의 버튼 스타일을 정의합니다.
    ///     - action: 버튼을 탭할 때 수행할 동작을 정의합니다.
    @ViewBuilder
    func tabButtonBuilder(
        _ style: SCTabBarButtonStyle,
        action: @escaping () -> Void
    ) -> some View {
        switch style {
        case .plain(let item):
            Button(action: action) {
                VStack(spacing: 2) {
                    Spacer()
                    
                    Image(item.imageName())
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 24,
                               height: 24)
                        .foregroundStyle(Color.brandColor(
                            color: viewStore.selectedTab == item ?
                            .sub1 : .gray1)
                        )
                    
                    Text(item.rawValue)
                        .pretendard(.caption)
                        .foregroundStyle(Color.brandColor(
                            color: viewStore.selectedTab == item ?
                            .sub1 : .gray1)
                        )
                }
                .frame(width: 45)
            }
            
        case .floating(let item):
            Button(action: action) {
                VStack(spacing: 3) {
                    Image(item.imageName())
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(Color.white)
                        .frame(width: 24,
                               height: 24)
                        .background {
                            Circle()
                                .foregroundStyle(
                                    Color.brandColor(
                                        color: .main
                                    )
                                )
                                .frame(width: 60, height: 60)
                        }
                        .frame(width: 60,
                               height: 60)
                    
                    Text(item.rawValue)
                        .pretendard(.caption)
                        .foregroundStyle(Color.brandColor(color: .gray1))
                }
                .frame(height: 77)
            }
        }
    }
}

//MARK: - View+SCTabBar

extension View {
    /// - Parameters:
    ///     - selectedTab: 선택한 탭을 정의합니다.
    /// - Returns: View에 SCTabBar를 overlay합니다.
    func scTabBar(store: StoreOf<SCTabBarFeature>) -> some View {
        modifier(SCTabBarAdoptViewModifier(store: store))
    }
}

//MARK: - SCTabBarAdoptViewModifier

/// - Parameters:
///     - selectedTab: 선택한 탭을 정의합니다.
struct SCTabBarAdoptViewModifier: ViewModifier {
//    @Binding var selectedTab: SCTabItem
    let store: StoreOf<SCTabBarFeature>
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            content
                .frame(maxHeight: .infinity)
            
            SCTabBar(store: store)
        }
    }
}

//MARK: - Preview

#Preview {
    VStack {
        Text("1")
        Text("1")
        Text("1")
        Text("1")
    }
    .scTabBar(store: .init(initialState: .init(),
                           reducer: { SCTabBarFeature() }))
}
