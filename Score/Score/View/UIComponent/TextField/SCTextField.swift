//
//  SCTextField.swift
//  Score
//
//  Created by sole on 3/29/24.
//

import SwiftUI

//MARK: - SCTextFieldStyle

enum SCTextFieldStyle {
    case plain
    case line
    case search
    /// - Parameters:
    ///     - lineLimit: TextEditor에서 나타낼 최대 줄 수
    case editor(lineLimit: Int = 1)
}

//MARK: - SCTextField

/// - Parameters:
///     - style: SCTextField의 스타일입니다.
///     - placeHolder: text가 비었을 때 표시할 문자열입니다.
///     - text: SCTextField에 입력할 문자열입니다.
struct SCTextField: View {
    let style: SCTextFieldStyle
    let placeHolder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeHolder,
                  text: $text,
                  axis: .vertical)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .modifier(SCTextFieldViewModifier(style: style))
            .tint(Color.brandColor(color: .main))
            .onTapGesture {
                hideKeyboard()
            }
    }
    
    //MARK: - trailingButtonItem
    
    // FIXME: 글자 수가 많아질 경우 버튼과 겹치는 현상 해결 필요
    /// textField trailing에 버튼을 추가합니다.
    /// - Parameters:
    ///     - action: 버튼을 눌렀을 때 실행될 action을 정의합니다.
    ///     - label: 버튼의 Label을 정의합니다.
    /// - Returns: trailing에 버튼이 overlay된 View가 반환됩니다.
    @ViewBuilder
    func trailingButtonItem<Label: View>(
        action: @escaping () -> (Void),
        @ViewBuilder label: () -> Label)
    -> some View {
        overlay(alignment: .trailing) {
            Button(action: action) {
                label()
            }
            .foregroundStyle(Color.brandColor(color: .icon))
            .padding(.trailing, 14)
        }
    }
}

//MARK: - SCTextFieldViewModifier

/// - Parameters:
///     - style: SCTextFieldStyle을 정의합니다.
struct SCTextFieldViewModifier: ViewModifier {
    let style: SCTextFieldStyle
    @FocusState var isFocused: Bool
    
    @ViewBuilder
    func body(content: Content) -> some View {
        switch style {

        case .plain:
            content
                .pretendard(.body3)
                .padding(.vertical, 18)
                .padding(.horizontal, 17)
                .overlay {
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.brandColor(color: .gray3))
                }
            
        case .line:
            content
                .pretendard(.body3)
                .padding(.bottom, 8)
                .edgeBorder(edges: [.bottom],
                            color: isFocused ? Color.brandColor(color: .main) :
                                Color.brandColor(color: .gray3))
                .focused($isFocused)
            
        case .search:
            content
                .pretendard(.body3)
                .padding(.vertical, 10)
                .padding(.horizontal, 14)
                .background(Color.brandColor(color: .gray2),
                            in: RoundedRectangle(cornerRadius: 10))
                .focused($isFocused)
        
        case .editor(let lineLimit):
            content
                .lineLimit(lineLimit,
                           reservesSpace: true)
                .pretendard(.body3)
                .padding(.vertical, 18)
                .padding(.horizontal, 17)
                .overlay {
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.brandColor(color: .gray3))
                }
        }
    }
}

//MARK: - Preview

/// SCTextField 모든 스타일 프리뷰 입니다.
#Preview {
    VStack {
        SCTextField(style: .plain,
                    placeHolder: "12312",
                    text: .constant("hi"))
        
        SCTextField(style: .line,
                    placeHolder: "12312",
                    text: .constant("hi"))
        .trailingButtonItem {
            
        } label: {
            Image(systemName: "xmark")
        }
        
        
        SCTextField(style: .search,
                    placeHolder: "22",
                    text: .constant("hi"))
        .trailingButtonItem {
            
        } label: {
            Image(systemName: "magnifyingglass")
        }
        
        SCTextField(style: .editor(lineLimit: 5),
                    placeHolder: "22",
                    text: .constant("hi"))
    }
    .padding(.horizontal, 24)
}
