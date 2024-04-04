//
//  View+.swift
//  Score
//
//  Created by sole on 3/29/24.
//

import SwiftUI

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

