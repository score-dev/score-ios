//
//  MapView.swift
//  Score
//
//  Created by sole on 8/14/24.
//

import ComposableArchitecture
import SwiftUI
import NMapsMap

struct MapView: UIViewControllerRepresentable {
    private let store: StoreOf<CurrentMapFeature>
    
    init(store: StoreOf<CurrentMapFeature>) {
        self.store = store
    }
    
    func makeUIViewController(
        context: Context
    ) -> some UIViewController {
        return MapViewController(store: store)
    }
    
    func updateUIViewController(
        _ uiViewController: UIViewControllerType,
        context: Context
    ) {
        
    }
}

#Preview {
    MapView(store: .init(initialState: .init(locationManager: .init()),
                         reducer: { CurrentMapFeature() }))
}
