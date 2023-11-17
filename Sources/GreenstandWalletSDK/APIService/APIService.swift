import Foundation

final class APIService {

    var apiKey: String?
    var rootURL: URL?
    private var token: String?

    private func headers(apiKey: String) -> [String: String] {

        var headers: [String: String] = [
            "TREETRACKER-API-KEY": apiKey,
            "Content-Type": "application/json"
        ]

        if let token {
            headers["Authorization"] = "Bearer \(token)"
        }

        return headers
    }

    func retrieveToken(rootWalletName: String, rootWalletPassword: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let request = AuthenticateAccountRequest(
            wallet: rootWalletName,
            password: rootWalletPassword
        )
        
        performAPIRequest(request: request) { [weak self] result in
            switch result {
            case .success(let response):
                self?.token = response.token
                completion(.success(()))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }

    func performRequest<Request: APIRequest>(request: Request, completion: @escaping (Result<Request.ResponseType, Error>) -> Void) {
        guard token != nil else {
            completion(.failure(GreenstandWalletSDKError.unauthenticated))
            return
        }
        
        performAPIRequest(request: request, completion: completion)
    }

    private func performAPIRequest<Request: APIRequest>(request: Request, completion: @escaping (Result<Request.ResponseType, Error>) -> Void) {

        guard let rootURL else {
            completion(.failure(GreenstandWalletSDKError.missingRootURL))
            return
        }

        guard let apiKey else {
            completion(.failure(GreenstandWalletSDKError.missingAPIKey))
            return
        }

        let headers = headers(apiKey: apiKey)
        let urlRequest = request.urlRequest(rootURL: rootURL, headers: headers)

        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in

            DispatchQueue.main.async {

                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data else {
                    return
                }

                if let response = response as? HTTPURLResponse, response.statusCode == 403 {
                    completion(.failure(GreenstandWalletSDKError.walletAlreadyExists))
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    /// Set a default Date Decoding strategy to handle all date transformations automatatically
                    decoder.dateDecodingStrategy = .formatted(.iso18601WithTZ)

                    let decodedObject = try decoder.decode(Request.ResponseType.self, from: data)
                    completion(.success(decodedObject))
                } catch {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }

    func clearToken() {
        token = nil
    }
}

private extension DateFormatter {

    static let iso18601WithTZ = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter
    }()
}
