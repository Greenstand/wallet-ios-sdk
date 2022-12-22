import Foundation

class KeychainService {
    static func saveToken(authToken: String) {
        let tokenData = authToken.data(using: .utf8)
        let query = [
            kSecValueData: tokenData,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: "access-token",
            kSecAttrAccount: "trings",
        ] as CFDictionary
        let status = SecItemAdd(query, nil)
        if status == errSecDuplicateItem {
            let query = [
                kSecAttrService: "access-token",
                kSecAttrAccount: "trings",
                kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
            let attributesToUpdate = [kSecValueData: tokenData] as CFDictionary
            SecItemUpdate(query, attributesToUpdate)
        }
        if status != errSecSuccess && status != errSecDuplicateItem {
            print("Error: \(status)")
        }
    }
    static func retrieveToken() -> String? {
        let query = [
            kSecAttrService: "access-token",
            kSecAttrAccount: "trings",
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        guard let token = result as? Data else { return nil}
        return String(data: token, encoding: .utf8)
    }
    static func removeToken() {
        let query = [
            kSecAttrService: "access-token",
            kSecAttrAccount: "trings",
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else { return }
    }
}
