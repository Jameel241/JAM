import Foundation
import Security

final class KeychainManager {

    static let shared = KeychainManager()

    private let service =
        Bundle.main.bundleIdentifier ?? "com.jameeliqbal.JAM"

    private init() { }

    func save(
        _ value: String,
        for account: String
    ) throws {

        guard let data = value.data(using: .utf8) else {
            throw KeychainError.invalidData
        }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]

        let attributes: [String: Any] = [
            kSecValueData as String: data
        ]

        let updateStatus = SecItemUpdate(
            query as CFDictionary,
            attributes as CFDictionary
        )

        if updateStatus == errSecSuccess {
            return
        }

        if updateStatus != errSecItemNotFound {
            throw KeychainError.unhandledStatus(updateStatus)
        }

        var newItem = query
        newItem[kSecValueData as String] = data

        let addStatus = SecItemAdd(
            newItem as CFDictionary,
            nil
        )

        guard addStatus == errSecSuccess else {
            throw KeychainError.unhandledStatus(addStatus)
        }
    }

    func load(for account: String) throws -> String? {

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var result: CFTypeRef?

        let status = SecItemCopyMatching(
            query as CFDictionary,
            &result
        )

        if status == errSecItemNotFound {
            return nil
        }

        guard status == errSecSuccess else {
            throw KeychainError.unhandledStatus(status)
        }

        guard
            let data = result as? Data,
            let value = String(data: data, encoding: .utf8)
        else {
            throw KeychainError.invalidData
        }

        return value
    }

    func delete(for account: String) throws {

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]

        let status = SecItemDelete(
            query as CFDictionary
        )

        guard
            status == errSecSuccess ||
            status == errSecItemNotFound
        else {
            throw KeychainError.unhandledStatus(status)
        }
    }
}

enum KeychainError: Error {

    case invalidData
    case unhandledStatus(OSStatus)
}
