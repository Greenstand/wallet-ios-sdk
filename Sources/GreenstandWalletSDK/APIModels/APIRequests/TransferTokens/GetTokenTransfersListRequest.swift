
import Foundation

struct GetTokenTransfersListRequest: APIRequest {

    struct Parameters: Encodable {
        let wallet: String
        let limit: String
    }

    typealias ResponseType = GetTokenTransfersListResponse
    let method: HTTPMethod = .GET
    let endpoint: Endpoint = .transfers
    let parameters: Parameters

    init(wallet: String, limit: Int = 10) {
        self.parameters = Parameters(wallet: wallet, limit: "\(limit)")
    }
}
