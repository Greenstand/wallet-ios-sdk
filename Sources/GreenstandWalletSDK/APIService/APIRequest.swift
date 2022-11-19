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

        let url = rootURL.appendingPathComponent(endpoint.rawValue)

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = try? JSONEncoder().encode(parameters)

        for header in headers {
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        }

        return urlRequest
    }
}
