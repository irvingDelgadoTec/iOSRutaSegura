//
//  RutaSeguraEntity.swift
//  RutaSegura
//
//  Created by Irving Delgado Silva on 29/11/22.
//

import Foundation

struct RutaSeguraEntity: Codable {
    let nodosRutaSegura: [Int]
    let costoRuta: Int
    
    enum CodingKeys: String, CodingKey {
        case nodosRutaSegura = "puntos"
        case costoRuta = "peso"
    }

}
