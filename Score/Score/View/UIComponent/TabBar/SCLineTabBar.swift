//
//  SCLineTabBar.swift
//  Score
//
//  Created by sole on 4/14/24.
//

import SwiftUI

//MARK: - SCLineTabBar

struct SCLineTabBar: View {
    var items: [String] = []
    
    @State var selectedValue: String
    
    //MARK: - init
    
    init(items: [String]) {
        self.items = items
        guard let firstElement = items.first
        else { 
            self.selectedValue = "defaultModel"
            return
        }
        self.selectedValue = firstElement
    }
    
    var body: some View {
        // - FIXME: 디자인 상의 필요, animation 적용
        HStack(spacing: 50) {
            ForEach(items,
                    id: \.self) { item in
                Text("\(item)")
                    .transition(.slide)
                    .modifier(
                        SCLineTabBarItemViewModifier(selectedValue: $selectedValue,
                                                     item: item)
                    )
            }
            
        }
        .frame(maxWidth: .infinity)
    }
}

//MARK: - SCLineTabBarItemViewModifier

struct SCLineTabBarItemViewModifier: ViewModifier {
    @Binding var selectedValue: String
    let item: String
    
    func body(content: Content) -> some View {
        Button {
            withAnimation {
                selectedValue = item
            }
        } label: {
            content
                .pretendard(.body2)
                .foregroundStyle(
                    selectedValue == item ?
                    Color.brandColor(color: .text1) :
                    Color.brandColor(color: .text3)
                )
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .frame(maxWidth: 120)
                .edgeBorder(lineWidth: 2,
                            edges: selectedValue == item ?
                            [.bottom] : [])
        }
    }
}

//MARK: - View+

extension View {
    //MARK: - scLineTabBar
    
    /// navigation을 적용할 View에 적용합니다.
    /// - Parameters:
    ///     - items: LineTabBarItem(TabBar title)을 정의합니다.
    @ViewBuilder
    func scLineTabBar(items: [String]) -> some View {
        VStack(alignment: .leading,
               spacing: 2) {
            SCLineTabBar(items: items)
            self
        }
    }
}

//MARK: - Preview

#Preview {
    Rectangle()
        .foregroundStyle(.mint)
        .scLineTabBar(items: ["피드(nn개)",
                              "캘린더"])
        .layout()
}
