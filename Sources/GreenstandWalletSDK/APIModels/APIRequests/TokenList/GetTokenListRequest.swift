
import Foundation

struct GetTokenListRequest: APIRequest {

    struct Parameters: Encodable {
        let wallet: String
        let limit: String
    }

    typealias ResponseType = GetTokenListResponse
    let endpoint: Endpoint = .tokens
    let method: HTTPMethod = .GET
    let parameters: Parameters
    
    init(walletName: String) {
        parameters = Parameters(wallet: walletName, limit: "100")
    }
}
