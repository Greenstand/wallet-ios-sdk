import Foundation

public struct Wallet: Decodable {

    let name: String
    let id: String
    let tokensInWallet: String
    let logoURL: String?

    private enum CodingKeys: String, CodingKey {
        case name
        case id
        case tokensInWallet = "tokens_in_wallet"
        case logoURL = "logo_url"
    }
}
