//
//  NetworkError.swift
//  NetworkLayer
//
//  Created by Irving Delgado Silva on 16/01/22.
//

public enum NetworkError: Error {
    case urlComponentError
    case requestError
    case decodeError(decodedetail: DecodingError)
    case other
    
}
extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .decodeError(let detail):
            // TODO: - replace prints by Os log
            var errorMessage = NSLocalizedString("", comment: "Networkerror")
            
            switch detail {
            case .typeMismatch(let type, let context):
                errorMessage = "Type \(type) mismatch: \(context.debugDescription)"
                print("codingPath:", context.codingPath)
            case .valueNotFound(let value, let context):
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            case .keyNotFound(let key, let context):
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            case .dataCorrupted(let context):
                print(context)

            @unknown default:
                print("unknown decode error")
            }
            
            return errorMessage
            
        case .urlComponentError:
            return NSLocalizedString("decode failed with urlComponentError", comment: "Networkerror")

        case .requestError:
            return NSLocalizedString("decode failed with requestError", comment: "Networkerror")

        case .other:
            return NSLocalizedString("decode failed with other", comment: "Networkerror")

        }
    }
}
