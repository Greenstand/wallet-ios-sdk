import Foundation

enum Endpoint: String {
    case wallets
    case getWallets = "wallets?limit=100"
    case transfers
    case auth
}
