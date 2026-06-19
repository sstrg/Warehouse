import SwiftUI

struct LoginView: View {

    @StateObject
    private var vm =
        LoginViewModel()

    var body: some View {

        if vm.isLoggedIn {

            ProductListView()

        } else {

            NavigationStack {

                VStack(spacing: 20) {

                    Text("Warehouse")
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

                    Button("Войти") {

                        Task {

                            await vm.login()
                        }
                    }
                    .buttonStyle(.borderedProminent)

                    NavigationLink(
                        "Нет аккаунта? Зарегистрироваться"
                    ) {

                        RegisterView()
                    }
                }
                .padding()
            }
        }
    }
}
