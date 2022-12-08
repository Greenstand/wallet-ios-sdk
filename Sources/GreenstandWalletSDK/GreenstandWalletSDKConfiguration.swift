import Foundation

public struct GreenstandWalletSDKConfiguration {
    let apiKey: String
    let rootURL: URL
    
    public init(apiKey: String, rootURL: URL){
        self.apiKey = apiKey
        self.rootURL = rootURL
    }
}
