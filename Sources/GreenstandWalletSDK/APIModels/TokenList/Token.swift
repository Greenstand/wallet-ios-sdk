
import Foundation

public struct Token: Decodable {
    public let id: String
    public let captureID: String
    public let walletID: String
    public let transferPending: Bool
    public let transferPendingID: String?
    public let createdAt: String?
    public let updatedAt: String?
    public let origin: String?
    public let claim: Bool
    
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
    public init(id: String, captureID: String, walletID: String, transferPending: Bool, transferPendingID: String?, createdAt: String?, updatedAt: String?, origin: String?, claim: Bool) {
        self.id = id
        self.captureID = captureID
        self.walletID = walletID
        self.transferPending = transferPending
        self.transferPendingID = transferPendingID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.origin = origin
        self.claim = claim
    }
}
