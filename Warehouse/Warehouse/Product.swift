import Foundation

struct Product: Codable, Identifiable {

    let id: Int
    var name: String
    var category: String
    var quantity: Int
    var location: String
}
