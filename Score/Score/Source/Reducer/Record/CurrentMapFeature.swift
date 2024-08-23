//
//  MapFeature.swift
//  Score
//
//  Created by sole on 8/16/24.
//

import CoreLocation
import ComposableArchitecture
import NMapsMap

@Reducer
struct CurrentMapFeature {
    struct State: Equatable {
        let locationManager: LocationManager
        
    }
    
    enum Action {
        case viewAppearing
        case setUpMapMarkers
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppearing:
                // setUp view
                return .none
                
            case .setUpMapMarkers:
                return .none
            }
        }
    }
}
