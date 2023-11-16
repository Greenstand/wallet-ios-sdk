
import Foundation
import XCTest

@testable import GreenstandWalletSDK


final class GetTokenTransfersListTests: XCTestCase {

    func testGetTokenTransfersListRequest() {
        let request = GetTokenTransfersListRequest(wallet: "TestWallet", limit: 100)

        XCTAssertEqual(request.endpoint, .transfers)
        XCTAssertEqual(request.method, .GET)
        XCTAssertEqual(request.parameters.wallet, "TestWallet")
        XCTAssertEqual(request.parameters.limit, "100")
    }

    func testGetTokenTransfersListResponse() throws {
        let data = """
            {
                "transfers": [
                    {
                        "id": "d733536a-e42b-45a1-9476-567fd9742f4d",
                        "type": "send",
                        "parameters": {
                            "bundle": {
                                "bundleSize": "1"
                            }
                        },
                        "state": "completed",
                        "created_at": "2023-09-25T06:51:28.141Z",
                        "closed_at": "2023-09-25T06:51:28.141Z",
                        "active": true,
                        "claim": false,
                        "originating_wallet": "TestWallet4",
                        "source_wallet": "TestWallet4",
                        "destination_wallet": "abc"
                    },
                    {
                        "id": "b58fa58d-226e-40f4-81ad-4573a300eeac",
                        "type": "send",
                        "parameters": {
                            "bundle": {
                                "bundleSize": "2"
                            }
                        },
                        "state": "completed",
                        "created_at": "2023-10-03T16:10:15.923Z",
                        "closed_at": "2023-10-03T16:10:15.923Z",
                        "active": true,
                        "claim": false,
                        "originating_wallet": "TestWallet4",
                        "source_wallet": "TestWallet4",
                        "destination_wallet": "abc"
                    }
                ]
            }
        """.data(using: .utf8)!

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        let decodedResponse = try decoder.decode(GetTokenTransfersListResponse.self, from: data)

        XCTAssertEqual(decodedResponse.transfers.count, 2)
        XCTAssertEqual(decodedResponse.transfers[0].id, "d733536a-e42b-45a1-9476-567fd9742f4d")
        XCTAssertEqual(decodedResponse.transfers[0].type, .send)
        XCTAssertEqual(decodedResponse.transfers[0].parameters.bundle.bundleSize, "1")
        XCTAssertEqual(decodedResponse.transfers[0].state, .completed)
        XCTAssertEqual(
            decodedResponse.transfers[0].createdAt.timeIntervalSince1970,
            Date(timeIntervalSince1970: 1695624688).timeIntervalSince1970, accuracy: 1)
        XCTAssertEqual(
            decodedResponse.transfers[0].closedAt.timeIntervalSince1970,
            Date(timeIntervalSince1970: 1695624688).timeIntervalSince1970, accuracy: 1)
        XCTAssertEqual(decodedResponse.transfers[0].isActive, true)
        XCTAssertEqual(decodedResponse.transfers[0].isClaim, false)
        XCTAssertEqual(decodedResponse.transfers[0].originatingWallet, "TestWallet4")
        XCTAssertEqual(decodedResponse.transfers[0].sourceWallet, "TestWallet4")
        XCTAssertEqual(decodedResponse.transfers[0].destinationWallet, "abc")
    }
}
