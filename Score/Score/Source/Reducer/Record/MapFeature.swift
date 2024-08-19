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
struct MapFeature {
    struct State: Equatable {
        var locations: [NMGLatLng] = []
    }
    
    enum Action {
        case updatingLocations(locations: [CLLocation])
    }
    
    
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .updatingLocations(let locations):
                state.locations += locations.map{ .init(lat: $0.coordinate.latitude, lng: $0.coordinate.longitude)}
                return .none
            }
        }
    }
}
