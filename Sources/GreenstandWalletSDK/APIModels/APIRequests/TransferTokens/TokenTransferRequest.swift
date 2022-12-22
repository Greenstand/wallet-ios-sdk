import Foundation

public struct TokenTransferRequest: APIRequest {

    struct Parameters: Encodable {

        struct Bundle: Encodable {
            let bundleSize: Int

            private enum CodingKeys: String, CodingKey {
                case bundleSize = "bundle_size"
            }
        }

        let bundle: Bundle
        let senderWallet: String
        let receiverWallet: String

        private enum CodingKeys: String, CodingKey {
            case bundle
            case senderWallet = "sender_wallet"
            case receiverWallet = "receiver_wallet"
        }
    }

    typealias ResponseType = TokenTransferResponse
    let method: HTTPMethod = .POST
    let endpoint: Endpoint = .transfers
    let parameters: Parameters

    init(senderWallet: String, receiverWallet: String, amount: Int) {
        self.parameters = Parameters(
            bundle: Parameters.Bundle(bundleSize: amount),
            senderWallet: senderWallet,
            receiverWallet: receiverWallet
        )
    }
}
