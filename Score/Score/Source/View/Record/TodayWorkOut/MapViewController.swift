//
//  MapViewController.swift
//  Score
//
//  Created by sole on 8/14/24.
//

import ComposableArchitecture
import NMapsMap
import UIKit
import SwiftUI
import Combine

final class MapViewController: UIViewController {
    private let store: StoreOf<MapFeature> = .init(initialState: .init(), reducer: { MapFeature() })
    private var cancellable: Set<AnyCancellable> = .init()
    
    private var naverMapView: NMFNaverMapView!
    private var locationManager: LocationManager!
    
    private let pathOverlay: NMFPath = {
        let pathOverlay: NMFPath = .init()
        pathOverlay.color = UIColor(.brandColor(color: .main))
        pathOverlay.outlineWidth = 0
        return pathOverlay
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpLocationManager()
        self.setUpMapView()
        self.setUpCamera()
        self.setUpMapMarker()
        view.addSubview(naverMapView)
        
        store.publisher.locations
            .sink{ [weak self] in
                self?.overlayMapPath(locations: $0)
            }
            .store(in: &cancellable)
    }
    
    /// locationManager 관련 설정을 세팅합니다. 
    func setUpLocationManager() {
        self.locationManager = .init(store: store)
        self.locationManager.requestAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    /// 지도 관련 설정을 세팅합니다.
    func setUpMapView() {
        self.naverMapView = .init(frame: view.frame)
        self.naverMapView.showCompass = false
        self.naverMapView.showZoomControls = false
        self.naverMapView.mapView.isScrollGestureEnabled = false
        self.naverMapView.mapView.isRotateGestureEnabled = false
        self.naverMapView.mapView.minZoomLevel = 5
        self.naverMapView.mapView.maxZoomLevel = 18
        self.naverMapView.mapView.positionMode = .direction
    }
    
    /// camera 위치를 현재 유저의 위치로 설정합니다.
    func setUpCamera() {
        guard let currentLocation = locationManager.location 
        else { return }

        let position: NMFCameraPosition = .init(
            .init(
                lat: currentLocation.coordinate.latitude,
                lng: currentLocation.coordinate.longitude
                 ),
            zoom: 18
        )
        let cameraUpdate: NMFCameraUpdate = .init(position: position)
        self.naverMapView.mapView.moveCamera(cameraUpdate)
    }
    
    // FIXME: UIImage로 Rendering이 제대로 되지 않는 문제 해결 해야 함.
    func setUpMapMarker() {
        let locationOverlay = self.naverMapView.mapView.locationOverlay
        let markerVC = SCMapMarker(isFocused: true).asUIViewController()
//        let markerUIImage: UIImage = markerVC.view.asUIImage(bounds: self.view.bounds)
        let markerUIImage: UIImage = .apple
        let overlayImage: NMFOverlayImage = .init(image: markerUIImage)
        locationOverlay.icon = overlayImage
    }
    
    /// 유저가 지나온 경로를 그립니다.
    func overlayMapPath(locations: [NMGLatLng]) {
        // point가 2개 이상인 경우에만 실행됩니다.
        guard locations.count > 1
        else { return }
        self.pathOverlay.path = .init(points: locations)
        self.pathOverlay.mapView = self.naverMapView.mapView
    }
    
    deinit {
        cancellable.forEach{ $0.cancel() }
    }
}

extension UIView {
    func asUIImage(bounds: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        let uiImage = renderer.image { context in
            self.layer.render(in: context.cgContext)
        }
        return uiImage
    }
}


extension View {
    func asUIViewController() -> UIViewController {
        UIHostingController(rootView: self)
    }
}
