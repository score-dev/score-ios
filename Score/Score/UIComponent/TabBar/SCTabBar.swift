//
//  SCTabBar.swift
//  Score
//
//  Created by sole on 4/2/24.
//

import SwiftUI

//MARK: - SCTabBarButtonStyle

@frozen
enum SCTabBarButtonStyle {
    case plain(item: SCTabItem)
    case floating(item: SCTabItem)
}

//MARK: - SCTabItem

enum SCTabItem: String {
    case home = "홈"
    case record = "기록하기"
    case schoolGroup = "학교 그룹"
    
    func imageName() -> String {
        switch self {
        case .home:
            return Constants.ImageName.home.rawValue
        case .record:
            return Constants.ImageName.footsteps.rawValue
        case .schoolGroup:
            return Constants.ImageName.groupUsers.rawValue
        }
    }
}

//MARK: - SCTabBar

/// - Parameters:
///     - selectedTab: 선택한 탭을 정의합니다.
struct SCTabBar: View {
    @Binding var selectedTab: SCTabItem
    
    var body: some View {
        HStack(spacing: 54) {
            tabButtonBuilder(.plain(item: .home)) {
                selectedTab = .home
            }
            
            tabButtonBuilder(.floating(item: .record)) {
                selectedTab = .record
            }
            
            tabButtonBuilder(.plain(item: .schoolGroup)) {
                selectedTab = .schoolGroup
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 10)
        .background {
            Rectangle()
                .foregroundStyle(Color.white)
                .frame(height: 56)
            //FIXME: 배경과 탭바 사이 경계 나타내는 방식의 변경 필요
                .shadow(radius: 12, x: 0, y: 0)
//                .border(Color.brandColor(color: .gray1),
//                        width: 0.5)
                .offset(y: 15)
        }
        .frame(height: 56)
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
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color.brandColor(color: selectedTab == item ?
                            .gray1 : .sub1))
                    
                    Text(item.rawValue)
                        .pretendard(.caption)
                        .foregroundStyle(Color.brandColor(color: selectedTab == item ?
                            .gray1 : .sub1))
                }
            }
            
        case .floating(let item):
            Button(action: action) {
                VStack(spacing: 3) {
                    Image(item.imageName())
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(Color.white)
                        .frame(width: 24, height: 24)
                        .background {
                            Circle()
                                .foregroundStyle(Color.brandColor(color: .main))
                                .frame(width: 60, height: 60)
                        }
                        .frame(width: 60, height: 60)
                    
                    Text(item.rawValue)
                        .pretendard(.caption)
                        .foregroundStyle(Color.brandColor(color: .gray1))
                }
            }
        }
    }
}

//MARK: - View+SCTabBar

extension View {
    /// - Parameters:
    ///     - selectedTab: 선택한 탭을 정의합니다.
    /// - Returns: View에 SCTabBar를 overlay합니다.
    func scTabBar(selectedTab: Binding<SCTabItem>) -> some View {
        modifier(SCTabBarAdoptViewModifier(selectedTab: selectedTab))
    }
}

//MARK: - SCTabBarAdoptViewModifier

/// - Parameters:
///     - selectedTab: 선택한 탭을 정의합니다.
struct SCTabBarAdoptViewModifier: ViewModifier {
    @Binding var selectedTab: SCTabItem
    
    func body(content: Content) -> some View {
        ZStack {
            content
                
            VStack {
                Spacer()
                
                SCTabBar(selectedTab: $selectedTab)
            }
            .zIndex(3)
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
    .scTabBar(selectedTab: .constant(.home))
}
