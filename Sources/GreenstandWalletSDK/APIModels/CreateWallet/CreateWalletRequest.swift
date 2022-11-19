import Foundation

struct CreateWalletRequest: APIRequest {

    struct Parameters: Encodable {
        let wallet: String
    }

    typealias ResponseType = CreateWalletResponse
    let method: HTTPMethod = .POST
    let endpoint: Endpoint = .wallets
    let parameters: Parameters

    init(walletName: String) {
        parameters = Parameters(wallet: walletName)
    }
}
