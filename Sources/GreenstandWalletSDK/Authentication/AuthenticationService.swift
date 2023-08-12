import Foundation
import UIKit
import AppAuth

// NOTE: This is currently WIP
class AuthenticationService {

    private var currentAuthorizationFlow: OIDExternalUserAgentSession?
    private var authState: OIDAuthState?

    var authorizationEndpoint: URL?
    var tokenEndpoint: URL?
    var clientId: String?
    var redirectURL: URL?
    var userInfoEndpoint: URL?

    private lazy var configuration: OIDServiceConfiguration? = {
        guard let authorizationEndpoint,
                let tokenEndpoint else {
            return nil
        }
        return OIDServiceConfiguration(
            authorizationEndpoint: authorizationEndpoint,
            tokenEndpoint: tokenEndpoint
        )
    }()

    func authorize(presentingViewController: UIViewController) throws {

        guard let configuration, let redirectURL, let clientId  else {
            throw GreenstandWalletSDKError.invalidAuthenticationConfig
        }

        let request = OIDAuthorizationRequest(
            configuration: configuration,
            clientId: clientId,
            clientSecret: nil,
            scopes: [OIDScopeOpenID, OIDScopeProfile],
            redirectURL: redirectURL,
            responseType: OIDResponseTypeCode,
            additionalParameters: nil
        )

        currentAuthorizationFlow = OIDAuthState.authState(byPresenting: request, presenting: presentingViewController) { authState, error in
            if let authState = authState {
                self.authState = authState
                print("Got authorization tokens. Access token: " +
                      "\(authState.lastTokenResponse?.accessToken ?? "nil")")
            } else {
                print("Authorization error: \(error?.localizedDescription ?? "Unknown error")")
                self.authState = nil
            }
        }
    }

    func getUserInfo() throws {

        guard let userInfoEndpoint else {
            throw GreenstandWalletSDKError.invalidAuthenticationConfig
        }

        self.authState?.performAction() { (accessToken, idToken, error) in

            if error != nil  {
              print("Error fetching fresh tokens: \(error?.localizedDescription ?? "Unknown error")")
              return
            }
            guard let accessToken = accessToken else {
              return
            }

            // Add Bearer token to request
            var urlRequest = URLRequest(url: userInfoEndpoint)
            urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(accessToken)"]

            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let response {
                    print("Reponse: \(response)")
                }
                if let data, let dataString = String(data: data, encoding: .utf8) {
                    print("Data: \(dataString)")
                }
                if let error {
                    print("Error: \(error)")
                }
            }.resume()
        }
    }

    // To be called from the app delegate application open URL function
    func application(_open url: URL) -> Bool {
      // Sends the URL to the current authorization flow (if any) which will
      // process it if it relates to an authorization response.
      if let currentAuthorizationFlow, currentAuthorizationFlow.resumeExternalUserAgentFlow(with: url) {
          self.currentAuthorizationFlow = nil
          return true
      }
      return false
    }
}
