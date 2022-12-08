//
//  GeoJSONFeatureEntity.swift
//  RutaSegura
//
//  Created by Arturo Valdes on 07/12/22.
//

import Foundation

struct GeoJSONFeature: Codable {
    let type: String
    let features: [Feature]
}

struct Feature: Codable {
    let type: String
    let properties: Properties
    let geometry: Geometry
}

struct Geometry: Codable {
    let type: String
    let coordinates: [[[Double]]]
}

struct Properties: Codable {
    let cuadrante, municipio, zona, sector: String
    let cveMun: String
    
    enum CodingKeys: String, CodingKey {
        case cuadrante, municipio, zona, sector
        case cveMun = "cve_mun"
    }
}
