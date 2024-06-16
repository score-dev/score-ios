//
//  Image+.swift
//  Score
//
//  Created by sole on 4/27/24.
//

import SwiftUI

//MARK: - Image+imagePlaceHolder

extension Image {
    //MARK: - imagePlaceHolder
    
    /// image 플레이스 홀더가 필요한 사진의 경우에 사용합니다.
    /// 플레이스 홀더를 원형의 size*size로 생성합니다.
    @ViewBuilder
    func imagePlaceHolder(size: CGFloat) -> some View {
        self
            .resizable()
            .frame(width: 130,
                   height: 130)
            .clipShape(Circle())
            .background {
                Circle()
                    .frame(width: size,
                           height: size)
                    .foregroundStyle(
                        Color.brandColor(color: .gray2)
                    )
            }
            .frame(width: size,
                   height: size)
    }
}

//MARK: - Image?+imagePlaceHolder

extension Image? {
    //MARK: - imagePlaceHolder
    
    @ViewBuilder
    func imagePlaceHolder(size: CGFloat) -> some View {
        let image: Image = self ?? Image("")
        image
            .resizable()
            .frame(width: 130,
                   height: 130)
            .clipShape(Circle())
            .background {
                Circle()
                    .frame(width: size,
                           height: size)
                    .foregroundStyle(
                        Color.brandColor(color: .gray2)
                    )
            }
            .frame(width: size,
                   height: size)
    }
}
