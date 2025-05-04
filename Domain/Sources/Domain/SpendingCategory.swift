public struct SpendingCategory: Hashable, Sendable {
    public let name: String
    public let budget: BudgetPair
    
    public init(name: String, budget: BudgetPair) {
        self.name = name
        self.budget = budget
    }
}
