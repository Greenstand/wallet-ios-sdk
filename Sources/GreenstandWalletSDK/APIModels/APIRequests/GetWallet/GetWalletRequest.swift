import Foundation

struct GetSpecificWalletRequest: APIRequest {
    struct Parameters: Encodable {
        let name: String
    }
    typealias ResponseType = GetWalletsResponse
    let endpoint: Endpoint = .wallet
    let method: HTTPMethod = .GET
    let parameters: Parameters
    
    init(walletName: String) {
        parameters = Parameters(name: walletName)
    }
}
