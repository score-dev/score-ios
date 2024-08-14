//
//  MapViewController.swift
//  Score
//
//  Created by sole on 8/14/24.
//

import NMapsMap
import UIKit

final class MapViewController: UIViewController {
    private var naverMapView: NMFNaverMapView!
    private var locationManager: LocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpLocationManager()
        self.naverMapView = .init(frame: view.frame)
        self.setUpMapView()
        self.setUpCamera()
        view.addSubview(naverMapView)
    }
    
    /// locationManager 관련 설정을 세팅합니다. 
    func setUpLocationManager() {
        self.locationManager = .init()
        self.locationManager.requestAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    /// 지도 interaction 관련 설정을 세팅합니다.
    func setUpMapView() {
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
    
    func requestLocations() -> [CLLocationCoordinate2D] {
        self.locationManager.locations.map{ $0.coordinate }
    }
}

