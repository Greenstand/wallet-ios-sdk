
import Foundation
import XCTest

@testable import GreenstandWalletSDK


final class GetTokenTransfersListRequestTests: XCTestCase {

    func testGetTokenTransfersListRequest() {
        let request = GetTokenTransfersListRequest(wallet: "TestWallet", limit: 100)

        XCTAssertEqual(request.endpoint, .transfers)
        XCTAssertEqual(request.method, .GET)
        XCTAssertEqual(request.parameters.wallet, "TestWallet")
        XCTAssertEqual(request.parameters.limit, "100")
    }
}
