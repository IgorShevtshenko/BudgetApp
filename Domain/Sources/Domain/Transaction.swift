public struct Transaction: Identifiable, Hashable {
    public let id: String
    public let merchant: String
    public let amount: Double
    
    public init(id: String, merchant: String, amount: Double) {
        self.id = id
        self.merchant = merchant
        self.amount = amount
    }
}
