import SwiftUI

struct ProductListView: View {
    
    @StateObject
    private var vm =
    ProductListViewModel()
    
    var body: some View {
        
        NavigationStack {
            
            List {
                ForEach(vm.products) { product in
                    NavigationLink {
                        EditProductView(
                            product: product
                        )
                    } label: {
                        ProductRowView(
                            product: product
                        )
                    }
                }
                .onDelete { indexSet in
                    Task {
                        for index in indexSet {
                            let product =
                                vm.products[index]
                            try? await APIService
                                .shared
                                .deleteProduct(
                                    id: product.id
                                )
                        }
                        await vm.load()
                    }
                }
            }
            .navigationTitle(
                "Склад"
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AddProductView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .task {
                await vm.load()
            }
        }
    }
}
