//
//  SCMapMarker.swift
//  Score
//
//  Created by sole on 8/15/24.
//

import SwiftUI

struct SCMapMarker: View {
    let isFocused: Bool
    let hour: Int = 0
    let minute: Int = 0
    var image: Image?
    
    var formattedTimeString: String {
        let hourString = String(format: "%02d", hour)
        let minuteString = String(format: "%02d", minute)
        return "\(hourString):\(minuteString)"
    }
    
    var body: some View {
        VStack(spacing: 4) {
            VStack(spacing: -12) {
                timeChipBuilder()
                    .zIndex(1)
                
                UnevenRoundedRectangle(
                    topLeadingRadius: 28,
                    bottomLeadingRadius: 5,
                    bottomTrailingRadius: 28,
                    topTrailingRadius: 28
                )
                .rectFrame(size: 56)
                .foregroundStyle(.white)
                .shadow(radius: 5)
                .rotationEffect(.degrees(-45))
                .overlay {
                    Image(.apple)
                        .imagePlaceHolder(size: 48)
                }
            }
            .zIndex(1)
            
            userPositionMarkerBuilder()
        }
    }
    
    @ViewBuilder
    private func timeChipBuilder() -> some View {
        Text(formattedTimeString)
            .pretendard(weight: .bold, size: .xs)
            .padding(.vertical, 3)
            .padding(.horizontal, 10)
            .foregroundStyle(isFocused ? .white : .brandColor(color: .text2))
            .background(isFocused ? .black : .brandColor(color: .gray2))
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    @ViewBuilder
    private func userPositionMarkerBuilder() -> some View {
        Circle()
            .foregroundStyle(.white)
            .rectFrame(size: 15)
            .overlay {
                Circle()
                    .rectFrame(size: 12)
                    .foregroundStyle(
                        isFocused ?
                        Color.brandColor(color: .main) : Color.brandColor(color: .gray1)
                    )
            }
    }
}

//final class SCMarkerUIView: UIView {
//    let isFocusedUser: Bool
//    var hour: Int
//    var minute: Int
//    
//    private var formattedTimeString: String {
//        let hourString = String(format: "%02d", hour)
//        let minuteString = String(format: "%02d", minute)
//        return "\(hourString):\(minuteString)"
//    }
//    
//    private lazy var timeLabel: UILabel = {
//        let timeLabel: UILabel = .init(frame: .zero)
//        timeLabel.text = formattedTimeString
//        timeLabel.backgroundColor = isFocusedUser ? .black : UIColor(.brandColor(color: .gray2))
//        timeLabel.textColor = isFocusedUser ? .white : UIColor(.brandColor(color: .text2))
//        timeLabel.layer.cornerRadius = 12
//        return timeLabel
//    }()
//    
//    init(
//        isFocusedUser: Bool,
//        hour: Int,
//        minute: Int
//    ) {
//        self.isFocusedUser = isFocusedUser
//        self.hour = hour
//        self.minute = minute
//        super.init(frame: .zero)
//        self.setUI()
//    }
//    
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    
//    private func setUI() {
//        self.backgroundColor = .white
//        let unevenRectangle: UIView = .init()
//        unevenRectangle.backgroundColor = .white
//        
//        unevenRectangle.layer.cornerRadius = 28
//        unevenRectangle.layer.maskedCorners = [.layerMinXMinYCorner]
//        
//        [timeLabel].forEach{ self.addSubview($0) }
//    
//        
//        timeLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            timeLabel.topAnchor.constraint(equalTo: self.topAnchor),
//            timeLabel.heightAnchor.constraint(equalToConstant: 61)
//        ])
//        timeLabel.layoutMargins.left = 1000
//    }
//    
//    private func updateUI() {
//        
//    }
//}

//struct Test: UIViewRepresentable {
//    func makeUIView(context: Context) -> some UIView {
//        SCMarkerUIView(isFocusedUser: true, hour: 0, minute: 0)
//    }
//    func updateUIView(_ uiView: UIViewType, context: Context) {
//        
//    }
//}

#Preview {
    VStack(spacing: 20) {
        Spacer()
        SCMapMarker(isFocused: true)
        SCMapMarker(isFocused: false)
        Spacer()
//        Test()
    }
    .frame(maxWidth: .infinity)
    .background(.blue)
}
