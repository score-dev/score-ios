//
//  SCTextField.swift
//  Score
//
//  Created by sole on 3/29/24.
//

import SwiftUI

//MARK: - SCTextFieldStyle

enum SCTextFieldStyle {
    case plain(error: SCTextFieldError? = nil)
    case line(error: SCTextFieldError? = nil)
    case search
    /// - Parameters:
    ///     - lineLimit: TextEditor에서 나타낼 최대 줄 수
    case editor(lineLimit: Int = 1)
}

//MARK: - SCTextFieldError

// - FIXME: error message 변경 필요
enum SCTextFieldError: String,
                       Error {
    case emptyFieldError = "빈 텍스트 필드입니다."
    case regexError = "형식에 맞지 않습니다."
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
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    //MARK: - scButtonItem
    
    /// SCTextField trailing에 버튼이 추가된 형태로 반환됩니다.
    /// - Parameters:
    ///     - action: 버튼을 탭했을 때 수행할 동작을 정의합니다.
    ///     - label: 버튼의 Label을 정의합니다.
    @ViewBuilder
    func scButtonItem<C: View>(
        action: @escaping () -> (Void),
        @ViewBuilder label: () -> C
    ) -> some View {
        HStack {
            TextField(placeHolder,
                      text: $text,
                      axis: .horizontal)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            
            Spacer()
            
            Button(action: action) {
                label()
            }
        }
        .modifier(SCTextFieldViewModifier(style: style))
        .onTapGesture {
            hideKeyboard()
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
        case .plain(let error):
            content
                .pretendard(.body3)
                .padding(.vertical, 18)
                .padding(.horizontal, 17)
                .tint(
                    error == nil ?
                    Color.brandColor(color: .main):
                    Color.brandColor(color: .red)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(
                            isFocused ?
                            Color.brandColor(color: .main) :
                            Color.brandColor(color: .gray3)
                        )
                }
                .overlay {
                    if error != nil {
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(
                                Color.brandColor(color: .red)
                            )
                    }
                }
                .focused($isFocused)
            
        case .line(let error):
            content
                .pretendard(.body3)
                .padding(.bottom, 8)
                .tint(
                    error == nil ?
                    Color.brandColor(color: .main):
                    Color.brandColor(color: .red)
                )
                .edgeBorder(edges: [.bottom],
                            color: isFocused ?
                            .brandColor(color: .main) :
                            .brandColor(color: .gray3))
                .edgeBorder(edges: [.bottom],
                            color: error != nil ?
                            .brandColor(color: .red) :
                            .clear
                )
                .focused($isFocused)
            
        case .search:
            content
                .pretendard(.body3)
                .padding(.vertical, 10)
                .padding(.horizontal, 14)
            // - FIXME: 디자인 쪽에 확인
                .tint(.brandColor(color: .text3))
                .background(Color.brandColor(color: .gray2),
                            in: RoundedRectangle(cornerRadius: 10))
                .focused($isFocused)
            
        case .editor(let lineLimit):
            content
                .lineLimit(lineLimit,
                           reservesSpace: true)
                .pretendard(.body3)
                .tint(.brandColor(color: .main))
                .padding(.vertical, 18)
                .padding(.horizontal, 17)
                .overlay {
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(
                            isFocused ?
                            Color.brandColor(color: .main) :
                            Color.brandColor(color: .gray3)
                        )
                }
                .focused($isFocused)
        }
    }
}

//MARK: - Preview

/// SCTextField 모든 스타일 프리뷰 입니다.
#Preview {
    VStack {
        SCTextField(style: .plain(error: .emptyFieldError),
                    placeHolder: "12312",
                    text: .constant("hi"))
        .scButtonItem {
            print("1")
        } label: {
            Image(systemName: "checkmark")
        }
        
        SCTextField(style: .plain(),
                    placeHolder: "12312",
                    text: .constant("hi"))
        .scButtonItem {
            print("1")
        } label: {
            Image(systemName: "checkmark")
        }
        
        
        SCTextField(style: .line(),
                    placeHolder: "12312",
                    text: .constant("hi"))
        .scButtonItem {
            print("1")
        } label: {
            Image(systemName: "checkmark")
        }
        
        SCTextField(style: .line(error: .emptyFieldError),
                    placeHolder: "12312",
                    text: .constant("hi"))
        .scButtonItem {
            print("1")
        } label: {
            Image(systemName: "checkmark")
        }
        
        SCTextField(style: .search,
                    placeHolder: "22",
                    text: .constant("hi"))
        .scButtonItem {
            print("1")
        } label: {
            Image(systemName: "checkmark")
                .foregroundStyle(Color.brandColor(color: .icon))
        }
        
        SCTextField(style: .editor(lineLimit: 5),
                    placeHolder: "22",
                    text: .constant("hi"))
    }
    .padding(.horizontal, 24)
}
