import Foundation

struct GetWalletsRequest: APIRequest {
    struct Parameters: Encodable { }
    typealias ResponseType = GetWalletsResponse
    let endpoint: Endpoint = .wallets
    let method: HTTPMethod = .GET
    let parameters: Parameters = Parameters()
}
