struct Product: Codable {
    let name: String
    let detail: String
    let price: Int
    let oldPrice: Int
    let image: String
    let count: Int
    
    func increaseCount() -> Product {
        Product(name: name, detail: detail, price: price, oldPrice: oldPrice, image: image, count: count + 1)
    }
}

extension Product: Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.name == rhs.name &&
               lhs.detail == rhs.detail &&
               lhs.price == rhs.price
    }
}


