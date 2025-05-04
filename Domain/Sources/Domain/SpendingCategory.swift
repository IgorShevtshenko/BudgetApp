public struct SpendingCategory: Hashable, Identifiable, Sendable {
    public let id: String
    public let name: String
    public let budget: BudgetPair
    
    public init(id: String, name: String, budget: BudgetPair) {
        self.id = id
        self.name = name
        self.budget = budget
    }
}
