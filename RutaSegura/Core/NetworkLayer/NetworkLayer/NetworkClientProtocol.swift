//
//  NetworkClientProtocol.swift
//  NetworkLayer
//
//  Created by Irving Delgado Silva on 16/01/22.
//

import RxSwift
import RxCocoa

public protocol NetworkClientProtocol {
    
    var session: URLSession { get }
    var baseURL: URL { get }

    // Reactive approach
    func performRequestAndDecode<T: Codable>(networkRequest: NetworkRequestProtocol) throws -> Observable<T>
    
    func performRequest(urlRequest: URLRequest) -> Observable<Data>

    // Non-reactive fetch
    func performRequestAndDecode<T: Codable>(networkRequest: NetworkRequestProtocol, completion: @escaping (Result<T, NetworkError>) -> Void) throws

}
