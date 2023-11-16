//
//  Transfer.swift
//  trings
//
//  Created by Drew Barnes on 13/11/2023.
//

import Foundation

public struct Transfer: Decodable {

    public enum TransferType: Decodable {
        case send
        case receive
    }

    public enum TransferState: Decodable {
        case all
        case requested
        case pending
        case completed
        case cancelled
        case failed
    }

    public struct Parameters: Decodable {

        public struct Bundle: Decodable {
            public let bundleSize: String
        }

        public let bundle: Bundle
    }

    public let id: String
    public let `type`: TransferType
    public let parameters: Parameters
    public let state: TransferState
    public let createdAt: Date
    public let closedAt: Date
    public let isActive: Bool
    public let isClaim: Bool
    public let originatingWallet: String
    public let sourceWallet: String
    public let destinationWallet: String

    enum CodingKeys: String, CodingKey {
        case id
        case `type`
        case parameters
        case state
        case createdAt = "created_at"
        case closedAt = "closed_at"
        case isActive = "active"
        case isClaim = "claim"
        case originatingWallet = "originating_wallet"
        case sourceWallet = "source_wallet"
        case destinationWallet = "destination_wallet"
    }
}
