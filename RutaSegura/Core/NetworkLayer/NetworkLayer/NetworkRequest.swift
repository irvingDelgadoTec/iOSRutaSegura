//
//  NetworkRequest.swift
//  NetworkLayer
//
//  Created by Irving Delgado Silva on 16/01/22.
//
public enum RequestMethod: String {
    case GET, POST, PUT
}

public protocol NetworkRequestProtocol {
    var method: RequestMethod { get }
    var path: String { get }
    var parameters: [String: String]? { get }
    var headers: [String: String]? { get }
    
    func getRequest(with baseURL: URL) throws -> URLRequest

}

final public class NetworkRequest: NetworkRequestProtocol {
    
   public var method: RequestMethod
   public var path: String
   public var parameters: [String: String]?
   public var headers: [String: String]?
    
    public init(method: RequestMethod, path: String, parameters: [String: String]? = nil, headers: [String: String]? = nil) {
        self.method = method
        self.path = path
        self.parameters = parameters
        self.headers = headers
    }
    
    public func getRequest(with baseURL: URL) throws -> URLRequest {
        
        guard var urlComponents = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
            throw NetworkError.urlComponentError
        }

        // Adding parameters
        if let urlParameters = parameters {
            urlComponents.queryItems = urlParameters.map {
                URLQueryItem(name: String($0), value: String($1))
            }
        }

        guard let url = urlComponents.url else {
            throw NetworkError.urlComponentError
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
                
        // Adding Headers
        if let requestHeaders = headers {
            _ = requestHeaders.map {
                request.addValue(String($1), forHTTPHeaderField: String($0))
            }
        }
        
        return request
    }
}
