import Foundation

struct GetTreeDetailsRequest: APIRequest {

    struct Parameters: Encodable {
        let tokenId: String

        private enum CodingKeys: String, CodingKey {
            case tokenId = "token_id"
        }
    }

    typealias ResponseType = GetTreeDetailsResponse
    let endpoint: Endpoint = .trees
    let method: HTTPMethod = .GET
    let parameters: Parameters
    
    init(tokenId: String) {
        parameters = Parameters(tokenId: tokenId)
    }
}
