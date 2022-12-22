import Foundation

protocol APIRequest {
    var method: HTTPMethod { get }
    var endpoint: Endpoint { get }
    associatedtype ResponseType: Decodable
    associatedtype Parameters: Encodable
    var parameters: Parameters { get }
}

extension APIRequest {

    func urlRequest(rootURL: URL, headers: [String: String]) -> URLRequest {
        
        var url = rootURL.appendingPathComponent(endpoint.rawValue)
        if method == .GET {
            
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
            let properties = Mirror(reflecting: parameters)
            var queryItems: [URLQueryItem] = []
            for child in properties.children {
                if let label = child.label, let value = child.value as? String{
                    queryItems.append(URLQueryItem(name: label, value: value))
                }
            }
            
            urlComponents?.queryItems = queryItems
            url = (urlComponents?.url)!
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        if encodesParametersInURL {

            let encodedURL: URL? = {

                guard let jsonData = try? JSONEncoder().encode(parameters),
                        let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any]
                else {
                    return nil
                }

                var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
                urlComponents?.queryItems = jsonObject.map { (key, value) in
                    return URLQueryItem(name: key, value: "\(value)")
                }
                return urlComponents?.url
            }()

            if let encodedURL {
                urlRequest.url = encodedURL
            }

        } else {
            urlRequest.httpBody = try? JSONEncoder().encode(parameters)
        }

        for header in headers {
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        }

        return urlRequest
    }

    private var encodesParametersInURL: Bool {
        switch method {
        case .GET: return true
        case .POST: return false
        }
    }
}
