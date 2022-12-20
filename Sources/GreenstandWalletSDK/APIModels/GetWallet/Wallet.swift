import Foundation

public struct Wallet: Decodable {

    public let name: String
    public let id: String
    public let tokensInWallet: String?
    public let logoURL: String?
    public let coverUrl: String?
    public let createdAt: Date?

    private enum CodingKeys: String, CodingKey {
        case name
        case id
        case tokensInWallet = "tokens_in_wallet"
        case logoURL = "logo_url"
        case coverUrl = "cover_url"
        case createdAt = "created_at"
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(String.self, forKey: .id)
        self.tokensInWallet = try container.decodeIfPresent(String.self, forKey: .tokensInWallet)
        self.logoURL = try container.decodeIfPresent(String.self, forKey: .logoURL)
        self.coverUrl = try container.decodeIfPresent(String.self, forKey: .coverUrl)
        if let createdString = try? container.decodeIfPresent(String.self, forKey: .createdAt) {
            var dateString = String(createdString.split(separator: "T")[0])
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            print(dateString)
            self.createdAt = dateFormatter.date(from:dateString)
        } else {
            self.createdAt = nil
        }
    }
}
