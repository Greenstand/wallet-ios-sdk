import Foundation

struct GetWalletsRequest: APIRequest {
    struct Parameters: Encodable { }
    typealias ResponseType = GetWalletsResponse
    let endpoint: Endpoint = .getWallets
    let method: HTTPMethod = .GET
    let parameters: Parameters = Parameters()
}
