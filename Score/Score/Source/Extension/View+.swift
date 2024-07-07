//
//  View+.swift
//  Score
//
//  Created by sole on 3/29/24.
//

import SwiftUI

//MARK: - View+Feature

extension View {
    //MARK: - hideKeyBoard
    
    /// 키보드를 비활성화 하는 메서드 입니다.
    /// 키보드 외 뷰 영역을 터치했을 때 사용합니다. 
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil,
                                        from: nil,
                                        for: nil)
    }
}

//MARK: - View+UI

extension View {
    //MARK: - layout
    @ViewBuilder
    func layout() -> some View{
        padding(.horizontal,
                Constants.Layout.horizontal.rawValue)
    }
    
    //MARK: - layoutOfCalendarItem
    
    @ViewBuilder
    func layoutOfCalendarItem() -> some View {
        // 양쪽에 padding이 들어가므로 2배를 곱해줍니다.
        let paddingHorizontal: CGFloat = Constants.Layout.horizontal.rawValue * 2
        frame(
            width: (.deviceWidth - paddingHorizontal) / 7,
            height: (.deviceWidth - paddingHorizontal) / 7
        )
    }
    
    @ViewBuilder
    func rectFrame(size: CGFloat) -> some View {
        self
            .frame(width: size,
                   height: size)
    }
}

//MARK: - View+hideKeyBoard

extension View {
    //MARK: - enableHideKeyBoard
    
    /// View tap gesture시 keyboard가 disable 되도록 하는 설정입니다.
    /// 뷰 전체 영역에서 작동합니다. 
    @ViewBuilder
    func enableHideKeyBoard(
        backgroundColor: Color = .white
    ) -> some View {
        self
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity)
            .background(backgroundColor)
            .onTapGesture {
                hideKeyboard()
            }
    }
}
