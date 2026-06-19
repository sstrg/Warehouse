import Foundation
internal import Combine

@MainActor
final class LoginViewModel:
ObservableObject {

    @Published var username = ""

    @Published var password = ""

    @Published var isLoggedIn = false

    func login() async {

        do {

            try await AuthService
                .shared
                .login(
                    username: username,
                    password: password
                )

            isLoggedIn = true

        } catch {

            print(error)
        }
    }
}
