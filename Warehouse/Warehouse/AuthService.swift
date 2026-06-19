import Foundation

final class AuthService {

    static let shared = AuthService()

    private let baseURL =
        "http://192.168.3.67:8000"
    
    func register(
        username: String,
        password: String
    ) async throws {

        let url = URL(
            string: "\(baseURL)/register"
        )!

        var request =
            URLRequest(url: url)

        request.httpMethod = "POST"

        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )

        let body = RegisterRequest(
            username: username,
            password: password
        )

        request.httpBody =
            try JSONEncoder()
                .encode(body)

        _ = try await URLSession
            .shared
            .data(for: request)
    }

    func login(
        username: String,
        password: String
    ) async throws {

        let url = URL(
            string: "\(baseURL)/login"
        )!

        var request =
            URLRequest(url: url)

        request.httpMethod = "POST"

        request.setValue(
            "application/json",
            forHTTPHeaderField:
                "Content-Type"
        )

        let body = LoginRequest(
            username: username,
            password: password
        )

        request.httpBody =
            try JSONEncoder()
                .encode(body)

        let (data, _) =
            try await URLSession
                .shared
                .data(for: request)

        let response =
            try JSONDecoder()
                .decode(
                    LoginResponse.self,
                    from: data
                )

        TokenManager
            .shared
            .save(
                token: response.access_token
            )
    }
}
