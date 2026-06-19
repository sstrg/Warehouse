import Foundation
internal import Combine

@MainActor
final class ProductListViewModel:
ObservableObject {

    @Published var products:
        [Product] = []

    func load() async {

        do {

            products =
                try await APIService
                    .shared
                    .fetchProducts()

        } catch {

            print(error)
        }
    }
}
