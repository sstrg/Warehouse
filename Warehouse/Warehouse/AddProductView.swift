import SwiftUI

struct AddProductView: View {

    @Environment(\.dismiss)
    private var dismiss

    @State private var name = ""
    @State private var category = ""
    @State private var quantity = ""
    @State private var location = ""
    @State private var isLoading = false

    var body: some View {

        Form {

            TextField(
                "Название",
                text: $name
            )

            TextField(
                "Категория",
                text: $category
            )

            TextField(
                "Количество",
                text: $quantity
            )
            .keyboardType(.numberPad)

            TextField(
                "Место хранения",
                text: $location
            )

            Button("Добавить") {
                isLoading = true
                Task {
                    await createProduct()
                    isLoading = false
                }
            }
            .disabled(isLoading)
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Добавить товар")
    }

    func createProduct() async {

        guard let qty = Int(quantity)
        else { return }

        do {

            try await APIService.shared
                .createProduct(
                    name: name,
                    category: category,
                    quantity: qty,
                    location: location
                )

            dismiss()

        } catch {

            print(error)
        }
    }
}
