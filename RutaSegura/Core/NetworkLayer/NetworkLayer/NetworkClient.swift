//
//  NetworkClient.swift
//  NetworkLayer
//
//  Created by Irving Delgado Silva on 16/01/22.
//
import RxSwift
import RxCocoa

public final class NetworkClient: NetworkClientProtocol {
    
    public let session: URLSession
    public let baseURL: URL
    
    // No URLsessionConfig init
    public init(baseURL: URL) {
        self.baseURL = baseURL
        self.session = URLSession.shared
    }
    
    public init(baseURL: URL, session: URLSession) {
        self.baseURL = baseURL
        self.session = session
    }
    
    public init(baseURL: URL, sessionConfig: URLSessionConfiguration) {
        self.baseURL = baseURL
        self.session = URLSession(configuration: sessionConfig)
    }

}

// MARK: - NetworkClientProtocol methods' implementation HINT: You cannot add a completed or error event onto relays at all, so they’re great for non-terminating sequences. (drive too)
extension NetworkClient {
    
    // TODO: - Test/handle termination of sequence when erroring
    public func performRequestAndDecode<T: Codable>(networkRequest: NetworkRequestProtocol) throws -> Observable<T> {

        do {
            let request = try networkRequest.getRequest(with: baseURL)
            
            return performRequest(urlRequest: request)
                .map { data in
                    
                    do {
                        return try JSONDecoder().decode(T.self, from: data)

                    } catch let decodeErr as DecodingError {
                               
                        throw NetworkError.decodeError(decodedetail: decodeErr)
                        
                    } catch {
                        
                        throw error
                    }
                    
                }
        } catch {
            throw error
        }

    }
    
    public func performRequest(urlRequest: URLRequest) -> Observable<Data> {
            return session.rx.data(request: urlRequest)
    }
    
    public func fetchImage(networkRequest: NetworkRequestProtocol) throws -> Observable<UIImage?> {
        
        do {
            let request = try networkRequest.getRequest(with: baseURL)

            return performRequest(urlRequest: request)
                .map { data in

                    let img = UIImage(data: data)

                    return img
                    
                }
        } catch {
            throw error
        }
    }

    // Non-reactive approach.
    public func performRequestAndDecode<T: Codable>(networkRequest: NetworkRequestProtocol, completion: @escaping (Result<T, NetworkError>) -> Void) throws {
        do {
            
            let request = try networkRequest.getRequest(with: baseURL)
            
            session.dataTask(with: request) { data, response, _ in
                
                guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode), let data = data else {
                    completion(.failure(.requestError))
                    return
                }
                do {
                    let decodedValue = try JSONDecoder().decode(T.self, from: data)
                    completion(.success( decodedValue ))
                                    
                } catch let decodeErr as DecodingError {
                           
                    completion(.failure(
                        .decodeError(decodedetail: decodeErr))  )
                    
                } catch {
                    completion(.failure(.other))
                }
                
            }.resume()
        } catch {
            throw error
        }
        
    }
}
