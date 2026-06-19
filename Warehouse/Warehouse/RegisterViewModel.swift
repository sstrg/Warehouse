import Foundation
internal import Combine

@MainActor
final class RegisterViewModel:
ObservableObject {

    @Published var username = ""

    @Published var password = ""

    @Published var confirmPassword = ""

    @Published var registrationSuccess = false

    func register() async {

        guard password == confirmPassword
        else {
            return
        }

        do {

            try await AuthService
                .shared
                .register(
                    username: username,
                    password: password
                )

            registrationSuccess = true

        } catch {

            print(error)
        }
    }
}
