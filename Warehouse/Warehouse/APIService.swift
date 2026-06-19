import Foundation

final class APIService {

    static let shared = APIService()

    private let baseURL =
        "http://192.168.3.67:8000"
    
    func createProduct(
        name: String,
        category: String,
        quantity: Int,
        location: String
    ) async throws {

        let url = URL(
            string: "\(baseURL)/products"
        )!

        var request =
            URLRequest(url: url)

        request.httpMethod = "POST"

        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )

        let body: [String: Any] = [
            "name": name,
            "category": category,
            "quantity": quantity,
            "location": location
        ]

        request.httpBody =
            try JSONSerialization
                .data(withJSONObject: body)

        _ = try await URLSession
            .shared
            .data(for: request)
    }

    func fetchProducts()
        async throws -> [Product] {

        let url = URL(
            string: "\(baseURL)/products"
        )!

        var request =
            URLRequest(url: url)

        if let token =
            TokenManager
                .shared
                .getToken() {

            request.setValue(
                "Bearer \(token)",
                forHTTPHeaderField:
                    "Authorization"
            )
        }

        let (data, _) =
            try await URLSession
                .shared
                .data(for: request)

        return try JSONDecoder()
            .decode(
                [Product].self,
                from: data
            )
    }
    
    func deleteProduct(
        id: Int
    ) async throws {

        let url = URL(
            string: "\(baseURL)/products/\(id)"
        )!

        var request =
            URLRequest(url: url)

        request.httpMethod = "DELETE"
        
        if let token =
            TokenManager
                .shared
                .getToken() {

            request.setValue(
                "Bearer \(token)",
                forHTTPHeaderField:
                    "Authorization"
            )
        }

        _ = try await URLSession
            .shared
            .data(for: request)
    }
    
    func updateProduct(
        product: Product
    ) async throws {

        let url = URL(
            string: "\(baseURL)/products/\(product.id)"
        )!

        var request =
            URLRequest(url: url)

        request.httpMethod = "PUT"

        request.setValue(
            "application/json",
            forHTTPHeaderField:
                "Content-Type"
        )
        
        if let token =
            TokenManager
                .shared
                .getToken() {

            request.setValue(
                "Bearer \(token)",
                forHTTPHeaderField:
                    "Authorization"
            )
        }

        request.httpBody =
            try JSONEncoder()
                .encode(product)

        _ = try await URLSession
            .shared
            .data(for: request)
    }
}
