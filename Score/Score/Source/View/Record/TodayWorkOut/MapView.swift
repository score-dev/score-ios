//
//  MapView.swift
//  Score
//
//  Created by sole on 8/14/24.
//

import SwiftUI
import NMapsMap

struct MapView: UIViewControllerRepresentable {
    func makeUIViewController(
        context: Context
    ) -> some UIViewController {
        return MapViewController()
    }
    
    func updateUIViewController(
        _ uiViewController: UIViewControllerType,
        context: Context
    ) {
        
    }
}

#Preview {
    MapView()
}
