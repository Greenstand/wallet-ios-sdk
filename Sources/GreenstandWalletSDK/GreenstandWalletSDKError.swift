import Foundation

public enum GreenstandWalletSDKError: Error {
    case walletNotFound
    case walletAlreadyExists
    case invalidURL
    case unauthenticated
    case missingAPIKey
    case missingRootURL
    case missingRootWalletName
    case missingRootWalletPassword
}
