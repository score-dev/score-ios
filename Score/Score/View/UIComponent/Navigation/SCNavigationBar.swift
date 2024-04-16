//
//  SCNavigationBar.swift
//  Score
//
//  Created by sole on 4/14/24.
//

import ComposableArchitecture
import SwiftUI

//MARK: - SCNavigationStyle

/// Navigation Bar를 display하는 방식을 정의합니다.
enum SCNavigationStyle {
    /// Parent View 위에 Navigation Bar를 올립니다.
    case overlay
    /// VStack으로 content위에 Navigation Bar를 쌓습니다.
    case vertical
}

//MARK: - SCNavigationBar

/// 기본 navigation style입니다. 
/// - Parameters:
///     - content: Navigation Bar에 표시하고 싶은 View를 정의합니다. 기본적으로 HStack으로 구현되어 있기 때문에 HStack을 선언하지 않고 필요한 Component를 나열합니다. .pretendard(.title)이 기본 설정입니다.
///     - style: Navigation Bar를 display하는 방식을 정의합니다.
struct SCNavigationBar<Content: View>: View {
    let style: SCNavigationStyle
//    @Dependency(\.dismiss) var dismiss
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        HStack(spacing: 4) {
            content()
                .pretendard(.title)
                .foregroundStyle(
                    Color.brandColor(color: .text1)
                )
            
            Spacer()
        }
        .padding(.vertical, 10)
        .layout()
    }
}

//MARK: - View+scNavigationBar

extension View {
    //MARK: - scNavigationBar
    
    /// - Parameters:
    ///     - content: Navigation Bar에 표시하고 싶은 View를 정의합니다. 기본적으로 HStack으로 구현되어 있기 때문에 HStack을 선언하지 않고 필요한 Component를 나열합니다.
    @ViewBuilder
    func scNavigationBar<Content: View>(
        style: SCNavigationStyle,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        switch style {
        case .overlay:
           self
                .toolbar(.hidden)
                .overlay(alignment: .topLeading) {
                    SCNavigationBar(style: style) {
                        content()
                    }
                }
            .frame(maxHeight: .infinity)
            
        case .vertical:
            VStack(alignment: .leading) {
                SCNavigationBar(style: style) {
                    content()
                }
                self
                    .toolbar(.hidden)
            }
            .frame(maxHeight: .infinity)
        }
    }
}

//MARK: - Preview1 (overlay)

#Preview {
    NavigationStack {
        ScrollView {
            Rectangle()
                .frame(height: 300)
            
            Rectangle()
                .foregroundStyle(Color.blue)
                .frame(height: 300)
            
            Rectangle()
                .foregroundStyle(Color.red)
                .frame(height: 300)
        }
        .toolbar {
            Image(systemName: "checkmark")
        }
        .navigationTitle("123")
        .scNavigationBar(style: .overlay) {
            DismissButton(color: .white) {
                
            }
            
            Text("마이페이지")
                .foregroundStyle(Color.white)
            Text("감자")
                .pretendard(.caption)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .background(
                    Color.brandColor(color: .main),
                    in: Capsule()
                )
        }
        .background(Color.mint)
    }
}

//MARK: - Preview2 (vertical)

#Preview {
    NavigationStack {
        ScrollView {
            Rectangle()
                .frame(height: 300)
            
            Rectangle()
                .foregroundStyle(Color.blue)
                .frame(height: 300)
            
            Rectangle()
                .foregroundStyle(Color.red)
                .frame(height: 300)
        }
        .toolbar {
            Image(systemName: "checkmark")
        }
        .scNavigationBar(style: .vertical) {
            DismissButton(color: .white) {
                
            }
            
            Text("마이페이지")
                .foregroundStyle(Color.white)
            Text("감자")
                .pretendard(.caption)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .background(Color.brandColor(color: .main),
                            in: Capsule())
        }
        .background(Color.mint)
    }
}