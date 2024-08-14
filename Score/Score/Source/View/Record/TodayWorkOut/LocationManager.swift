//
//  LocationManager.swift
//  Score
//
//  Created by sole on 8/14/24.
//

import CoreLocation
import os.log

final class LocationManager: CLLocationManager {
    private(set) var locations: [CLLocation] = []
    
    override init() {
        super.init()
        self.delegate = self
    }
    
    /// 위치 접근 권한이 없으면 위치 접근 권한을 요청하는 메서드입니다.
    func requestAuthorization() {
        switch self.authorizationStatus {
        case .notDetermined:
            self.requestWhenInUseAuthorization()
            logger.debug("\(#function) 위치 접근 권한이 설정되지 않았습니다.")
        case .restricted:
            logger.debug("\(#function) 위치 접근 권한이 제한적으로 설정되었습니다.")
        case .denied:
            // go to setting
            logger.debug("\(#function) 위치 접근 권한이 거부되었습니다.")
        case .authorizedAlways:
            logger.debug("\(#function) 위치 접근 권한이 항상 허용되었습니다.")
        case .authorizedWhenInUse:
            logger.debug("\(#function) 위치 접근 권한이 허용되었습니다.")
        @unknown default:
            logger.debug("\(#function) 알 수 없는 위치 권한입니다.")
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        self.locations += locations
    }
}

fileprivate let logger = Logger(subsystem: "sole.Score", category: "LocationManager")
