
import Foundation

enum APIError: Error {
    case failedResponse
    case failedDecoding
    case invalidUrl
    case invalidData
    case serverMessage(String)
    case timeout
    case emptyData
    
    var errorMessage: String {
        switch self {
        case .failedResponse:
            return "Failed to receive a valid response from the server."
        case .failedDecoding:
            return "Failed to decode the response from the server."
        case .invalidUrl:
            return "The URL provided is invalid."
        case .invalidData:
            return "The data provided is invalid."
        case .serverMessage(let message):
            return "Server Error: \(message)"
        case .timeout:
            return "The request timed out. Please try again later."
        case .emptyData:
           return "no data found"
        }
    }
}

struct ErrorResponse: Decodable {
    let error: ErrorDetail
    
    struct ErrorDetail: Decodable {
        let message: String
    }
}
