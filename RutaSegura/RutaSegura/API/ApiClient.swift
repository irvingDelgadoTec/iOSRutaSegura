//
//  ApiClient.swift
//  RutaSegura
//
//  Created by Irving Delgado Silva on 29/11/22.
//

import NetworkLayer

final class ApiClient {
    
    static let shared = ApiClient(baseUrl: URL(string: AppConstants.API.baseURL))
    
    public let networkClient: NetworkClient?
    
    public init(baseUrl: URL?) {
        if let base = baseUrl {
            networkClient = NetworkClient(baseURL: base)
        } else {
            networkClient = nil
        }
    }
}
