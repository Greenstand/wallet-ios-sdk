import Foundation

class APIService {

    var rootURL: URL?
    var apiKey: String?
    var rootWalletName: String?
    var rootWalletPassword: String?

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

    private func retrieveToken(completion: @escaping (Result<Void, Error>) -> Void) {

        guard let rootWalletName else {
            completion(.failure(GreenstandWalletSDKError.missingRootWalletName))
            return
        }

        guard let rootWalletPassword else {
            completion(.failure(GreenstandWalletSDKError.missingRootWalletPassword))
            return
        }

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
        if token != nil {
            performAPIRequest(request: request, completion: completion)
        } else {
            retrieveToken { [weak self] result in
                switch result {
                case .success:
                    self?.performAPIRequest(request: request, completion: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
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
                    let decodedObject = try JSONDecoder().decode(Request.ResponseType.self, from: data)
                    completion(.success(decodedObject))
                } catch {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }

    func clearToken() {
        self.token = nil
    }
}
