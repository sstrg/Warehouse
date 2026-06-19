import SwiftUI

struct EditProductView: View {

    @Environment(\.dismiss)
    private var dismiss

    @State private var product: Product
    @State private var isLoading = false

    init(product: Product) {
        _product = State(initialValue: product)
    }

    var body: some View {

        Form {

            TextField(
                "Название",
                text: $product.name
            )

            TextField(
                "Категория",
                text: $product.category
            )

            TextField(
                "Место",
                text: $product.location
            )

            Stepper(
                "Количество: \(product.quantity)",
                value: $product.quantity,
                in: 0...100000
            )

            Button("Сохранить") {
                isLoading = true
                Task {
                    do {
                        try await APIService
                            .shared
                            .updateProduct(
                                product: product
                            )
                        dismiss()
                    } catch {
                        print(error)
                        isLoading = false
                    }
                }
            }
            .disabled(isLoading)
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle(
            "Редактирование"
        )
    }
}
