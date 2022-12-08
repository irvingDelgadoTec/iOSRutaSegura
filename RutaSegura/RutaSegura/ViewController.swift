//
//  ViewController.swift
//  RutaSegura
//
//  Created by Irving Delgado Silva on 25/11/22.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    var initialRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 19.432608, longitude: -99.133209),
                                           span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
    
    @IBOutlet weak var MapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let geoJSONManager = GeoJSONManager()
        MapView.delegate = self
        MapView.setRegion(initialRegion, animated: true)
        
        // Map overlays (Each quadrant corresponds to an MKOverlay)
        // MapView.addOverlays(GetMapOverlaysOfAllQuadrants())
        MapView.addOverlays(geoJSONManager.GetMapOverlaysOfSpecificQuadrants(quadrants: ["C-1.2.4", "C-1.1.3", "N-4.4.3", "N-4.5.1", "N-4.5.2", "C-2.3.2", "N-4.5.2", "N-4.5.4"]))
    }

    // TODO: - ESTE ES UN TODO para triggear SwiftLint. 
}
