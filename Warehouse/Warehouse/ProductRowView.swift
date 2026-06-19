import SwiftUI

struct ProductRowView: View {

    let product: Product

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 4
        ) {

            Text(product.name)
                .font(.headline)

            Text(product.category)
                .font(.subheadline)
                .foregroundColor(.secondary)

            Text(
                "Количество: \(product.quantity)"
            )
            .font(.caption)

            Text(product.location)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}
