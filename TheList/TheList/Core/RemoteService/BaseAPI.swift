
import Foundation

class BaseAPI<T: TargetType> {

    func fetchData<M: Decodable>(target: T, responseClass: M.Type, completion: @escaping (Result<M?, NSError>) -> Void) {
        // Build URL
        guard var urlComponents = URLComponents(string: target.baseURL + target.path) else {
            let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: "Error building URL"])
            completion(.failure(error))
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
                    let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: "Error encoding parameters"])
                    completion(.failure(error))
                    return
                }
            }
        }

        guard let url = urlComponents.url else {
            let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: "Error creating URL"])
            completion(.failure(error))
            return
        }

        // Build request
        var request = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        target.headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }

        // Perform request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: "No internet connection"])
                completion(.failure(error))
                return
            }

            guard error == nil else {
                let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: "Generic error"])
                completion(.failure(error))
                return
            }

            guard httpResponse.statusCode == 200, let responseData = data else {
                let message = "Error Message Parsed From Server"
                let error = NSError(domain: target.baseURL, code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: message])
                completion(.failure(error))
                return
            }

            do {
                let responseObject = try JSONDecoder().decode(M.self, from: responseData)
                completion(.success(responseObject))
            } catch {
                let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: "Error parsing response"])
                completion(.failure(error))
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
