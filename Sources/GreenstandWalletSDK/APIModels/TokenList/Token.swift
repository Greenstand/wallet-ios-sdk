
import Foundation

public struct Token: Decodable {
    let id: String
    let captureID: String
    let walletID: String
    let transferPending: Bool
    let transferPendingID: String?
    let createdAt: String
    let updatedAt: String
    let origin: String?
    let claim: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id
        case captureID = "capture_id"
        case walletID = "wallet_id"
        case transferPending = "transfer_pending"
        case transferPendingID = "transfer_pending_id"
        case createdAt = "creadted_at"
        case updatedAt = "updated_at"
        case origin
        case claim
    }
}
