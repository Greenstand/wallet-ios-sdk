import Foundation

public enum GreenstandWalletSDKError: Error {

    // Missing Config
    case missingAPIKey
    case missingRootURL
    case missingRootWalletName
    case missingRootWalletPassword

    // Authentication Errors
    case unauthenticated

    // Wallet Errors
    case walletNotFound
    case walletAlreadyExists
}
