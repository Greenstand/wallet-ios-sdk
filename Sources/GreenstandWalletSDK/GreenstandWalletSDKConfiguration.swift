import Foundation

public struct GreenstandWalletSDKConfiguration {
    let apiKey: String
    let rootURL: URL
    let rootWalletName: String
    let rootPassword: String
    
    public init(apiKey: String, rootURL: URL, rootWalletName: String, rootPassword: String){
        self.apiKey = apiKey
        self.rootURL = rootURL
        self.rootWalletName = rootWalletName
        self.rootPassword = rootPassword
    }
}
