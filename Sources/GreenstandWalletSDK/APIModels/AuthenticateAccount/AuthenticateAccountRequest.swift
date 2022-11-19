import Foundation

struct AuthenticateAccountRequest: APIRequest {
    struct Parameters: Encodable {
        let wallet: String
        let password: String
    }

    typealias ResponseType = AuthenticateAccountResponse
    let endpoint: Endpoint = .auth
    let method: HTTPMethod = .POST
    let parameters: Parameters

    init(wallet: String, password: String) {
        self.parameters = Parameters(wallet: wallet, password: password)
    }
}
