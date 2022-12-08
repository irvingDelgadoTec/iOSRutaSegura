//
//  UIViewGeoJSON+.swift
//  RutaSegura
//
//  Created by Arturo Valdes on 07/12/22.
//

import UIKit
import MapKit

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        // Create an instance of MKPolygonRenderer
        let renderer = MKPolygonRenderer(overlay: overlay)
        
        // Setup appearance
        renderer.fillColor = UIColor.purple.withAlphaComponent(0.35)
        renderer.strokeColor = UIColor.purple.withAlphaComponent(0.5)
        renderer.lineWidth = 2
        
        return renderer
    }
}
