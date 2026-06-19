import SwiftUI

struct RegisterView: View {

    @Environment(\.dismiss)
    private var dismiss

    @StateObject
    private var vm =
        RegisterViewModel()

    var body: some View {

        VStack(spacing: 16) {

            Text("Регистрация")
                .font(.largeTitle)

            TextField(
                "Логин",
                text: $vm.username
            )
            .textFieldStyle(.roundedBorder)

            SecureField(
                "Пароль",
                text: $vm.password
            )
            .textFieldStyle(.roundedBorder)

            SecureField(
                "Повторите пароль",
                text: $vm.confirmPassword
            )
            .textFieldStyle(.roundedBorder)

            Button("Создать аккаунт") {

                Task {

                    await vm.register()

                    if vm.registrationSuccess {

                        dismiss()
                    }
                }
            }
            .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding()
    }
}
