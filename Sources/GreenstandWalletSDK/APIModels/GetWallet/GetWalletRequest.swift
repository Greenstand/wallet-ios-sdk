import Foundation

struct GetWalletsRequest: APIRequest {
    struct Parameters: Encodable {
        let limit: String
    }
    typealias ResponseType = GetWalletsResponse
    let endpoint: Endpoint = .wallets
    let method: HTTPMethod = .GET
    let parameters: Parameters
    
    init() {
        self.parameters = Parameters(limit: "100")
    }
}
