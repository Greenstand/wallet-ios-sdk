import Foundation

struct GetWalletsRequest: APIRequest {
    struct Parameters: Encodable {
        let limit: Int
    }
    
    typealias ResponseType = GetWalletsResponse
    let endpoint: Endpoint = .wallets
    let method: HTTPMethod = .GET
    let parameters: Parameters
    
    init(limit: Int) {
        self.parameters = Parameters(limit: limit)
    }
}
