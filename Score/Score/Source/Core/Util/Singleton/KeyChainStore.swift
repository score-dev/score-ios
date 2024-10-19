//
//  KeyChainStore.swift
//  Score
//
//  Created by sole on 5/21/24.
//

import Foundation

/// String을 Keychain에 저장할 수 있는 싱글톤 객체입니다.
final class KeyChainStore {
    static let shared: KeyChainStore = .init()
    // 데이터 무결성 보장을 위해 사용
    private let lock: NSLock = .init()

    private init() {}

    func create(key: String, value: String) throws {
        lock.lock()
        defer { lock.unlock() }

        guard let data = value.data(using: .utf8) else {
            throw KeyChainError.encodingError
        }
        //        guard let data = value.data(using: .utf8) else { return false }
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: data
        ]

        let status = SecItemAdd(query as CFDictionary, nil)
        if let error = KeyChainError(rawValue: status) {
            throw error
        }
    }

    func delete(key: String) throws {
        lock.lock()
        defer { lock.unlock() }

        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]

        let status = SecItemDelete(query as CFDictionary)
        if let error = KeyChainError(rawValue: status) {
            throw error
        }
    }

    func read(key: String) -> String? {
        lock.lock()
        defer { lock.unlock() }
        
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecAttrAccount: key,
            kSecReturnAttributes: true,
            kSecReturnData: true
        ]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        if let _ = KeyChainError(rawValue: status) { return nil }

      // 여러개를 요청한 경우 배열 형태로 들어옴 (아마 json 형태를 [String:Any]로 바꾸는 듯한?)
        // kSecMatchLimitAll을 한 경우 [[String:Any]]로 cast해주어야 함.
        guard let existingItem = item as? [CFString: Any],
              let valueData = existingItem[kSecValueData] as? Data,
              let value = String(data: valueData, encoding: .utf8) else { return nil }
        return value
    }

    func update<Value: Encodable>(key: String, updateValue: Value) throws {
        lock.lock()
        defer { lock.unlock() }

        guard let updateValueData = try? JSONCoder.encoder.encode(updateValue) else { throw KeyChainError.encodingError }
        // limit등 불필요한 쿼리가 들어가면 실패로 처리됨.
        let searchQuery: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]
        // update에 필요한 값만 들어가야 함.
        let updateQuery: [CFString: Any] = [
            kSecValueData: updateValueData
        ]

        let status = SecItemUpdate(searchQuery as CFDictionary, updateQuery as CFDictionary)
        if let error = KeyChainError(rawValue: status) {
            throw error
        }
    }
}

/// OSStatus를 wrapping한 구조체입니다.
/// localizedDescription은 SecCopyErrorMessageString을 반환합니다.
struct KeyChainStatus: Equatable {
    static let success: Self = .init(status: OSStatus(noErr))
    static let notFound: Self = .init(status: OSStatus(errSecDuplicateItem))
    static let alreadyExists: Self = .init(status: OSStatus(errSecDuplicateKeychain))
    static let invalidParameter: Self = .init(status: OSStatus(errSecParam))
    static let deleteKeyNotFound: Self = .init(status: OSStatus(errSecItemNotFound))

    let status: OSStatus
    var localizedDescription: String?

    init(status: OSStatus) {
        self.status = status
        self.localizedDescription = SecCopyErrorMessageString(status, nil) as? String
    }
}

/// OSStatus code와 일부 매핑됩니다.
enum KeyChainError: Int32, LocalizedError {
    case alreadyExists = -25299
    case keyNotFound = -25300
    case notFound = -25294
    case invalidParameter = -50
    case encodingError = 100
    case decodingError = 101
    case unknown = 600

    var errorDescription: String? {
        switch self {
        case .encodingError: "인코딩 에러"
        case .decodingError: "디코딩 에러"
        case .unknown: "알 수 없는 에러"
        case .alreadyExists: "이미 값이 존재합니다."
        case .keyNotFound: "찾을 수 없는 키입니다."
        case .notFound: "값을 찾을 수 없습니다."
        case .invalidParameter: "잘못된 쿼리 파라미터입니다."
        }
    }
}
