import Foundation

struct GetTreeDetailsRequest: APIRequest {
    struct Parameters: Encodable {
        let token_id: String
    }
    typealias ResponseType = TreeDetailsResponse
    let endpoint: Endpoint = .trees
    let method: HTTPMethod = .GET
    let parameters: Parameters
    
    init(tokenID: String) {
        parameters = Parameters(token_id: tokenID)
    }
}
