//
//  Camera.swift
//  Score
//
//  Created by sole on 7/22/24.
//

import AVFoundation
import UIKit
import os.log

final class Camera: NSObject {
    var coordinate: CameraCoordinate?
    let session: AVCaptureSession = .init()
    
    /// initialize를 할지 여부를 결정합니다.
    private var isFirstSetting: Bool = false
    private let sessionSerialQueue: DispatchQueue = .init(label: "camera.session.queue")
    
    /// session에 연결하는 input입니다.
    private var input: AVCaptureDeviceInput?
    /// session에 연결하는 output입니다.
    private var output: AVCapturePhotoOutput? = AVCapturePhotoOutput()
    
    /// support하는 front back deviceInput을 관리합니다.
    private var supportPosition: Set<AVCaptureDevice.Position> = []
    
    private var frontCamera: AVCaptureDevice? = AVCaptureDevice.DiscoverySession(
        deviceTypes: AVCaptureDevice.DeviceType.allCases,
        mediaType: .video,
        position: .front
    ).devices.first
    
    private var backCamera: AVCaptureDevice? = AVCaptureDevice.DiscoverySession(
        deviceTypes: AVCaptureDevice.DeviceType.allCases,
        mediaType: .video,
        position: .back
    ).devices.first
    
    private var frontCameraInput: AVCaptureDeviceInput?
    private var backCameraInput: AVCaptureDeviceInput?
    private var position: AVCaptureDevice.Position = .unspecified
   
    /// 카메라 권한 설정을 받습니다.
    static func requestAuthorization() async {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            logger.debug("카메라 권한이 설정되지 않았습니다.")
            await AVCaptureDevice.requestAccess(for: .video)
        case .authorized:
            logger.debug("카메라 권한이 승인되었습니다.")
        case .denied:
            logger.debug("카메라 권한이 거부되었습니다.")
            // 설정으로 이동
//            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString))
        case .restricted:
            logger.debug("카메라 권한이 제한적으로 설정되었습니다.")
        @unknown default:
            logger.debug("알 수 없는 카메라 권한입니다.")
        }
    }
    
    /// 설정 가능한 카메라를 초기화합니다.
    private func initialize() {
        if let backCamera,
           let backCameraInput = try? AVCaptureDeviceInput(device: backCamera) {
            self.backCameraInput = backCameraInput
            supportPosition.insert(.back)
        }
        
        if let frontCamera,
           let frontCameraInput = try? AVCaptureDeviceInput(device: frontCamera) {
            self.frontCameraInput = frontCameraInput
            supportPosition.insert(.front)
        }
        
        if let backCameraInput {
            self.input = backCameraInput
            position = .back
            return
        }
        
        if let frontCameraInput {
            self.input = frontCameraInput
            position = .front
        }
    }
    
    /// 카메라 세션 시작 전 세팅을 준비합니다.
    private func startConfiguration() throws {
        // Question - output은 한번만 추가해야 하나?
        guard !isFirstSetting else { return }
        self.isFirstSetting = true
        
        initialize()
        
        guard let input = self.input,
              let output = self.output,
              session.canAddInput(input),
              session.canAddOutput(output)
        else {
            logger.error("\(#function) 카메라 생성 실패")
            return
        }
        
        session.beginConfiguration()
        defer { session.commitConfiguration() }
        
        session.addInput(input)
        session.addOutput(output)
        session.sessionPreset = .photo
        logger.info("\(#function) \(self.session.inputs) \(self.session.outputs) \(self.session.connections)")
    }
    
    /// 카메라 세션을 시작합니다.
    func start() {
        guard !session.isRunning else { return }
        do {
            try self.startConfiguration()
            sessionSerialQueue.async { [weak self] in
                guard let self else { return }
                self.session.startRunning()
            }
        } catch {
            logger.error("\(#function) - \(error.localizedDescription)")
        }
    }
    
    /// 카메라 세션을 중지합니다.
    func stop() {
        guard session.isRunning else { return }
        sessionSerialQueue.async { [weak self] in
            guard let self else { return }
            self.session.stopRunning()
        }
    }
    
    /// 촬영 메서드입니다.
    func capture() {
        guard let output,
              let coordinate = self.coordinate
        else { return }
        output.capturePhoto(with: .init(), delegate: coordinate)
    }
    
    // FIXME: 전후면 모드 연속 전환 시 앱이 일시중지되면서 전후면이 변경되는 현상
    /// 카메라 전면, 후면 모드를 변환합니다.
    func flipPosition() {
        guard let input = self.input else { return }
        let flippedPosition: AVCaptureDevice.Position = (self.position == .back) ? .front : .back
        guard self.supportPosition.contains(flippedPosition) else { return }
        
        session.beginConfiguration()
        defer { session.commitConfiguration() }
        session.removeInput(input)
        self.input = (flippedPosition == .back) ? self.backCameraInput : self.frontCameraInput
        self.position = flippedPosition
        session.addInput(self.input ?? input)
    }
}


enum CameraError: Error {
    case inputFailed
    case outputFailed
    case connectionFailed
    case authorizationFailed
}

extension AVCaptureDevice.DeviceType {
    public static var allCases: [AVCaptureDevice.DeviceType] {
        [.builtInDualCamera,
         .builtInDualWideCamera,
         .builtInLiDARDepthCamera,
         .builtInTelephotoCamera,
         .builtInTripleCamera,
         .builtInTrueDepthCamera,
         .builtInUltraWideCamera,
         .builtInWideAngleCamera]
    }
}

fileprivate let logger = Logger(subsystem: "com.sole.Score", category: "Camera")
