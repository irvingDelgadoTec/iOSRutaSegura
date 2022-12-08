//
//  GeoJSONManager.swift
//  RutaSegura
//
//  Created by Arturo Valdes on 07/12/22.
//

import MapKit

struct GeoJSONManager {
    func GetMapOverlaysOfAllQuadrants () -> [MKOverlay] {
        // Load JSON
        guard let url = Bundle.main.url(forResource: "geojson", withExtension: "json") else {
            fatalError("Unable to load Mexico City's quadrants JSON.")
        }
        
        // Array of all GeoJSON objects, each one containign their corresponding features
        var geoJSONArray = [MKGeoJSONObject]()
        do {
            let data = try Data(contentsOf: url)
            geoJSONArray = try MKGeoJSONDecoder().decode(data)
        } catch {
            fatalError("Unable to decode Mexico City's quadrants GeoJSON.")
        }
        
        // Overlays array that can be added to a map for displaying them
        var overlays = [MKOverlay]()
        for item in geoJSONArray { // Each GeoJSON object
            if let feature = item as? MKGeoJSONFeature { // Convert each generic obejct feature to a 'MKGeoJSONFeature' that can be used by MapKit
                for geo in feature.geometry { // Get the geometry property of each MKGeoJSONFeature
                    if let polygon = geo as? MKPolygon { // Convert each polygon and their coordinates to a 'MKPolygon' that can be used by MapKit
                        overlays.append(polygon) // Append polygons only
                    }
                }
            }
        }
        
        return overlays
    }
    
    func GetMapOverlaysOfSpecificQuadrants(quadrants: [String]) -> [MKOverlay] {
        // Load JSON
        guard let url = Bundle.main.url(forResource: "geojson", withExtension: "json") else {
            fatalError("Unable to load Mexico City's quadrants JSON.")
        }
        
        // Array of all GeoJSON objects, each one containign their corresponding features
        var geoJSONArray = [MKGeoJSONObject]()
        do {
            let data = try Data(contentsOf: url)
            geoJSONArray = try MKGeoJSONDecoder().decode(data)
        } catch {
            fatalError("Unable to decode Mexico City's quadrants GeoJSON.")
        }
        
        // Overlays array that can be added to a map for displaying them
        var overlays = [MKOverlay]()
        var counter = 0
        let GeoJSONFeature = DecodeAndGetGeoJSONFeature()
        for item in geoJSONArray { // Each GeoJSON object
            if let feature = item as? MKGeoJSONFeature { // Convert each generic obejct feature to a 'MKGeoJSONFeature' that can be used by MapKit
                for geo in feature.geometry { // Get the geometry property of each MKGeoJSONFeature
                    if let polygon = geo as? MKPolygon { // Convert each polygon and their coordinates to a 'MKPolygon' that can be used by MapKit
                        for i in 0...quadrants.count - 1 {
                            if GeoJSONFeature.features[counter].properties.cuadrante == quadrants[i] {
                                overlays.append(polygon) // Append polygons only
                            }
                        }
                    }
                }
            }
            counter += 1
        }
        
        return overlays
    }
    
    func DecodeAndGetGeoJSONFeature() -> GeoJSONFeature {
        guard let url = Bundle.main.url(forResource: "geojson", withExtension: "json") else {
            fatalError("Unable to load Mexico City's quadrants JSON.")
        }
        
        var geoJSONPropertiesArray: GeoJSONFeature
        do {
            let data = try Data(contentsOf: url)
            geoJSONPropertiesArray = try JSONDecoder().decode(GeoJSONFeature.self, from: data)
        } catch {
            fatalError("Unable to decode Mexico City's quadrants GeoJSON.")
        }
        
        return geoJSONPropertiesArray
    }
}
