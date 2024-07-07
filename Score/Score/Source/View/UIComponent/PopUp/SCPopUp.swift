//
//  SCPopUp.swift
//  Score
//
//  Created by sole on 4/4/24.
//

import SwiftUI

//MARK: - SCPopUpStyle

enum SCPopUpStyle {
    /// 특정 조건이 달성되면 자동으로 나타났다 사라지는 뷰 스타일입니다.
    /// - Parameters:
    ///     - displayTime: displayTime초 만큼 toast를 보여줍니다.
    /// - padding(default)
    ///     - vertical: 15, horizontal: 30
    case toast(displayTime: Int)
    /// 사용자의 액션이 들어올 때까지 띄워져있는 뷰 스타일입니다.
    /// - padding(default)
    ///     - vertical: 16, horizontal: 14
    case dialog
}

//MARK: - SCPopUp

/// - Parameters:
///     - style: 팝업의 스타일을 정의합니다.
struct SCPopUp<Label: View>: View {
    let style: SCPopUpStyle
    @ViewBuilder let label: () -> Label
    
    var body: some View {
        label()
            .modifier(SCPopUpViewModifier(style: style))
    }
}

//MARK: - SCPopUpViewModifier

/// - Parameters:
///     - style: 팝업의 스타일을 정의합니다.
struct SCPopUpViewModifier: ViewModifier {
    let style: SCPopUpStyle
    
    @ViewBuilder
    func body(content: Content) -> some View {
        switch style {
        case .toast:
            content
                .padding(.vertical, 15)
                .padding(.horizontal, 30)
                .background(Color.white,
                            in: RoundedRectangle(cornerRadius: 10))
                .shadow(color: Color.brandColor(color: .sub1,
                                                alpha: 0.15),
                        radius: 10)
            
        case .dialog:
            content
                .padding(.vertical, 16)
                .padding(.horizontal, 14)
                .background(
                    Color.white,
                    in: RoundedRectangle(cornerRadius: 22)
                )
        }
    }
}

//MARK: - View+SCPopUp

extension View {
    
    //MARK: - scPopUp
    
    /// toast 기본 padding: (vertical: 15, horizontal: 30)
    /// dialog 기본 padding: (vertical: 16, horizontal: 14)
    @ViewBuilder
    func scPopUp<Content: View>(
        style: SCPopUpStyle,
        isPresented: Binding<Bool>,
        content: @escaping () -> Content
    ) -> some View {
        if isPresented.wrappedValue {
            switch style {
            case.toast(let displayTime):
                frame(maxWidth: .infinity,
                      maxHeight: .infinity)
                .overlay {
                    GeometryReader { proxy in
                        SCPopUp(style: style) {
                            content()
                        }
                        .animation(.spring)
                        .onTapGesture {
                            isPresented.wrappedValue = false
                        }
                        .position(
                            x: proxy.frame(in: .local).midX,
                            y: proxy.frame(in: .local).minY + proxy.safeAreaInsets.top
                        )
                    }
                }
                .transition(.move(edge: .top))
                /// displayTime만큼 toast를 보여줍니다.
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now().advanced(by: .seconds(displayTime))) {
                        isPresented.wrappedValue = false
                    }
                }
                
            case .dialog:
                frame(maxWidth: .infinity,
                      maxHeight: .infinity)
                .overlay {
                    ZStack {
                        Rectangle()
                            .foregroundStyle(
                                Color.brandColor(color: .gray1,
                                                 alpha: 0.5)
                            )
                        SCPopUp(style: style) {
                            content()
                        }
                        .padding(.horizontal, 24)
                    }
                }
            }
        } else {
            self
        }
    }
}

//MARK: - Preview

#Preview {
    VStack {
        SCPopUp(style: .toast(displayTime: 1)) {
            HStack {
                Image(Constants.ImageName.colorLetter.rawValue)
                Text("그룹 신청을 보냈어요")
            }
        }
        
        SCPopUp(style: .dialog) {
            Text("그룹 신청을 보냈어요")
        }
    }
    .background(Color.blue)
    .scPopUp(style: .toast(displayTime: 5),
             isPresented: .constant(true)) {
        Text("122343342342")
            .padding(.vertical, 12)
    }
}
