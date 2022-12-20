import Foundation
public protocol GreenstandWalletSDKProtocol {
    func createWallet(walletName: String, password: String, completion: @escaping (Result<String, Error>) -> Void)
    func signInWallet(walletName: String, password: String, completion: @escaping (Result<String, Error>) -> Void)
    func myWallet(completion: @escaping (Result<Wallet, Error>) -> Void)
    func purchaseTokens(amount: Int, completion: @escaping (Result<TokenPurchaseReceipt, Error>) -> Void)
    func sendTokens(amount: Int, receivingWalletName: String, completion: @escaping (Result<TokenTransferReceipt, Error>) -> Void)
    func setup(configuration: GreenstandWalletSDKConfiguration)
    func getTokens(completion: @escaping (Result<[Token], Error>) -> Void)
    func get(walletNamed wallet: String, completion: @escaping (Result<Wallet, Error>) ->Void)
}

public class GreenstandWalletSDK: GreenstandWalletSDKProtocol {

    private let apiService: APIService
    private var authenticatedWalletName: String?

    public static var shared: GreenstandWalletSDKProtocol = GreenstandWalletSDK(apiService: APIService())

    init(apiService: APIService) {
        self.apiService = apiService
    }

    public func setup(configuration: GreenstandWalletSDKConfiguration) {
        self.apiService.apiKey = configuration.apiKey
        self.apiService.rootURL = configuration.rootURL
        self.apiService.rootWalletName = configuration.rootWalletName
        self.apiService.rootWalletPassword = configuration.rootPassword
    }
    
    public func createWallet(walletName: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        let request = CreateWalletRequest(walletName: walletName)
        apiService.performRequest(request: request, completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.authenticatedWalletName = response.wallet
                completion(.success(response.wallet))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    public func signInWallet(walletName: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        let request = GetWalletsRequest()
        apiService.performRequest(request: request, completion: { [weak self] result in
            switch result {
            case .success(let response):
                guard let wallet = response.wallets.first(where: { $0.name == walletName}) else {
                    completion(.failure(GreenstandWalletSDKError.walletNotFound))
                    return
                }
                self?.authenticatedWalletName = wallet.name
                completion(.success(wallet.name))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    public func logOutWallet() {
        self.authenticatedWalletName = nil
        self.apiService.clearToken()
    }

    public func myWallet(completion: @escaping (Result<Wallet, Error>) -> Void) {

        guard let authenticatedWalletName = authenticatedWalletName else {
            completion(.failure(GreenstandWalletSDKError.unauthenticated))
            return
        }

        let request = GetWalletsRequest()
        apiService.performRequest(request: request, completion: { result in
            switch result {
            case .success(let response):
                guard let wallet = response.wallets.first(where: { $0.name == authenticatedWalletName}) else {
                    completion(.failure(GreenstandWalletSDKError.walletNotFound))
                    return
                }
                completion(.success(wallet))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    // MARK - For testing with specific wallets
    #warning("For Testing with specific wallets")
    public func get(walletNamed wallet: String, completion: @escaping (Result<Wallet, Error>) ->Void){
        let request = GetSpecificWalletRequest(walletName: wallet)
        apiService.performRequest(request: request) { result in
            switch result {
            case .success(let response):
                completion(.success(response.wallets[0]))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func purchaseTokens(amount: Int, completion: @escaping (Result<TokenPurchaseReceipt, Error>) -> Void) {
        completion(.success(TokenPurchaseReceipt(transactionId: "123", tokenAmount: amount, price: "$\(amount).00")))
    }

    public func sendTokens(amount: Int, receivingWalletName: String, completion: @escaping (Result<TokenTransferReceipt, Error>) -> Void) {

        guard let authenticatedWalletName = authenticatedWalletName else {
            completion(.failure(GreenstandWalletSDKError.unauthenticated))
            return
        }

        let request = TokenTransferRequest(
            senderWallet: authenticatedWalletName,
            receiverWallet: receivingWalletName,
            amount: amount
        )

        apiService.performRequest(request: request, completion: { result in
            switch result {
            case .success:
                completion(.success(TokenTransferReceipt()))
            case .failure(let error):
                completion(.failure(error))
            }
        })

        completion(.success(TokenTransferReceipt()))
    }
    public func getTokens(completion: @escaping (Result<[Token], Error>) -> Void) {
        guard let authenticatedWalletName = authenticatedWalletName else {
            completion(.failure(GreenstandWalletSDKError.unauthenticated))
            return
        }
        let request = GetTokenListRequest(walletName: authenticatedWalletName)
        apiService.performRequest(request: request) { result in
            switch result {
            case .success(let response):
                completion(.success(response.tokens))
            case .failure(let error):
                completion(.failure(GreenstandWalletSDKError.tokensNotFound))
                print(error)
            }
        }
    }
    public func getTreeDetails(forToken tokenID: String, completion: @escaping (Result<Tree, Error>) -> Void) {
        let request = GetTreeDetailsRequest(tokenID: tokenID)
        apiService.performRequest(request: request) { result in
            switch result {
            case .success(let response):
                completion(.success(response.tree))
            case .failure(let error):
                print(error)
            }
        }
    }
}
