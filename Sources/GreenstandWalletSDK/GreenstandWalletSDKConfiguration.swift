import Foundation

public struct GreenstandWalletSDKConfiguration {

    public struct WalletAPIConfiguration {
        let apiKey: String
        let rootURL: URL
        let rootWalletName: String
        let rootPassword: String

        public init(
            apiKey: String,
            rootURL: URL,
            rootWalletName: String,
            rootPassword: String
        ) {
            self.apiKey = apiKey
            self.rootURL = rootURL
            self.rootWalletName = rootWalletName
            self.rootPassword = rootPassword
        }
    }

    public struct AuthenticationServiceConfiguration {
        let authorizationEndpoint: URL
        let tokenEndpoint: URL
        let clientId: String
        let redirectURL: URL
        let userInfoEndpoint: URL

        public init(
            authorizationEndpoint: URL,
            tokenEndpoint: URL,
            clientId: String,
            redirectURL: URL,
            userInfoEndpoint: URL
        ) {
            self.authorizationEndpoint = authorizationEndpoint
            self.tokenEndpoint = tokenEndpoint
            self.clientId = clientId
            self.redirectURL = redirectURL
            self.userInfoEndpoint = userInfoEndpoint
        }
    }

    let walletAPIConfiguration: WalletAPIConfiguration
    let authenticationServiceConfiguration: AuthenticationServiceConfiguration

    public init(
        walletAPIConfiguration: WalletAPIConfiguration,
        authenticationServiceConfiguration: AuthenticationServiceConfiguration
    ) {
        self.walletAPIConfiguration = walletAPIConfiguration
        self.authenticationServiceConfiguration = authenticationServiceConfiguration
    }
}
