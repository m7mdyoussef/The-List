

import Foundation

enum HTTPMethod : String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum Task { //wrapper for my reqeust parameter
    case requestPlain
    case requestParameters(parameters:[String:Any],encoding: ParameterEncoding )
}

protocol TargetType { //wrapper that carries request properties
    var baseURL : String {get}
    var path: String {get}
    var method:HTTPMethod {get}
    var task:Task {get}
    var headers: [String:String]? {get}
}

enum ParameterEncoding {
    case urlEncoding
    case jsonEncoding
}


extension ParameterEncoding {
    func encode(urlRequest: inout URLRequest, parameters: [String: Any]?) throws {
        switch self {
        case .urlEncoding:
            guard let parameters = parameters else { return }
            var components = URLComponents(string: urlRequest.url!.absoluteString)!
            components.queryItems = parameters.map { key, value in
                URLQueryItem(name: key, value: "\(value)")
            }
            urlRequest.url = components.url
        case .jsonEncoding:
            guard let parameters = parameters else { return }
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    }
}
