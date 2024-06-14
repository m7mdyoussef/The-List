
import Foundation

class BaseAPI<T: TargetType> {
    
    func fetchData<M: Decodable>(target: T, responseClass: M.Type, completion: @escaping (Result<M?, APIError>) -> Void) {
        // Build URL
        guard var urlComponents = URLComponents(string: target.baseURL + target.path) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        // Build parameters
        let params = buildParams(task: target.task)
        if case .requestParameters(let parameters, let encoding) = target.task {
            switch encoding {
            case .urlEncoding:
                urlComponents.queryItems = params.0.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            case .jsonEncoding:
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
                    urlComponents.queryItems = [URLQueryItem(name: "data", value: String(data: jsonData, encoding: .utf8))]
                } catch {
                    completion(.failure(.invalidData))
                    return
                }
            }
        }
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidUrl))
            return
        }
        
        // Build request
        var request = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        target.headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        
        // Perform request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                if (error as NSError).code == NSURLErrorTimedOut {
                    completion(.failure(.timeout))
                } else {
                    completion(.failure(.failedResponse))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.failedResponse))
                return
            }
            
            guard httpResponse.statusCode == 200, let responseData = data else {
                if let responseData = data {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: responseData)
                        completion(.failure(.serverMessage(errorResponse.error.message)))
                    } catch {
                        completion(.failure(.failedDecoding))
                    }
                } else {
                    completion(.failure(.serverMessage(Constants.UnknownServerError)))
                }
                return
            }
            
            do {
                let responseObject = try JSONDecoder().decode(M.self, from: responseData)
                completion(.success(responseObject))
            } catch {
                completion(.failure(.failedDecoding))
            }
        }
        task.resume()
    }
    
    private func buildParams(task: Task) -> ([String: Any], ParameterEncoding) {
        switch task {
        case .requestPlain:
            return ([:], .urlEncoding)
        case .requestParameters(let parameters, let encoding):
            return (parameters, encoding)
        }
    }
    
    func cancelAnyRequest() {
        URLSession.shared.getAllTasks { tasks in
            tasks.forEach { $0.cancel() }
        }
    }
}
