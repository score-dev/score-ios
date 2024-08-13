//
//  CameraPreview.swift
//  Score
//
//  Created by sole on 7/22/24.
//

import AVFoundation
import ComposableArchitecture
import SwiftUI
import os.log

struct CameraPreview: UIViewRepresentable {
    private let store: StoreOf<CameraFeature>
    @ObservedObject private var viewStore: ViewStoreOf<CameraFeature>
    
    private let previewUIView: PreviewUIView
    
    init(store: StoreOf<CameraFeature>) {
        self.store = store
        self.viewStore = .init(store,
                               observe: { $0 })
        self.previewUIView = .init()
    }
    
    func makeUIView(context: Context) -> some UIView {
        previewUIView.videoPreviewLayer.session = self.viewStore.camera.session
        previewUIView.videoPreviewLayer.videoGravity = .resizeAspectFill
        return previewUIView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> CameraCoordinate {
        let coordinate = CameraCoordinate(self, store: store)
        viewStore.camera.coordinate = coordinate
        return coordinate
    }
    
    // MARK: - PreviewUIView
    
    final class PreviewUIView: UIView {
        override class var layerClass: AnyClass {
            return AVCaptureVideoPreviewLayer.self
        }
        
        var videoPreviewLayer: AVCaptureVideoPreviewLayer {
            return layer as! AVCaptureVideoPreviewLayer
        }
    }
}

// MARK: - CameraCoordinate

final class CameraCoordinate: NSObject, AVCapturePhotoCaptureDelegate {
    private let cameraPreview: CameraPreview
    private let store: StoreOf<CameraFeature>
    
    init(
        _ cameraPreview: CameraPreview,
        store: StoreOf<CameraFeature>
    ) {
        self.cameraPreview = cameraPreview
        self.store = store
    }
    func photoOutput(
        _ output: AVCapturePhotoOutput,
        willBeginCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings
    ) {
        
    }
    
    func photoOutput(
        _ output: AVCapturePhotoOutput,
        didFinishCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings,
        error: (any Error)?
    ) {
        if let error {
            logger.error("\(#function) - \(error.localizedDescription)")
        }
    }
    
    // 캡처 완료 후 실행되는 메서드입니다.
    func photoOutput(
        _ output: AVCapturePhotoOutput,
        didFinishProcessingPhoto photo: AVCapturePhoto,
        error: (any Error)?
    ) {
        if let error {
            print(error.localizedDescription)
            logger.error("\(#function) - \(error.localizedDescription)")
            return
        }
        
        guard let data = photo.fileDataRepresentation()
        else { return }
        
        store.send(.capturedImage(data: data))
    }
    
}

fileprivate let logger: Logger = .init(subsystem: "sole.Score", category: "CameraPreview")
