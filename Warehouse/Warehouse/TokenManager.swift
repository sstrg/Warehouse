import Foundation

final class TokenManager {

    static let shared = TokenManager()

    private init() {}

    private let key = "jwt_token"

    func save(token: String) {

        UserDefaults.standard.set(
            token,
            forKey: key
        )
    }

    func getToken() -> String? {

        UserDefaults.standard.string(
            forKey: key
        )
    }

    func removeToken() {

        UserDefaults.standard.removeObject(
            forKey: key
        )
    }
}
