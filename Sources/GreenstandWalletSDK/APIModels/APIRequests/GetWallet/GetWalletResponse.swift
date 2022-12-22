//
//  File.swift
//  
//
//  Created by Alex Cornforth on 22/12/2022.
//

import Foundation

struct GetWalletResponse: Decodable {
    let wallets: [Wallet]
}
