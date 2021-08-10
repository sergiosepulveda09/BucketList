//
//  MapViewExample.swift
//  BucketList
//
//  Created by Sergio Sepulveda on 2021-08-10.
//

import SwiftUI
import MapKit

struct MapViewExample: UIViewRepresentable {
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        return mapView
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
    
}

struct MapViewExample_Previews: PreviewProvider {
    static var previews: some View {
        MapViewExample()
    }
}
