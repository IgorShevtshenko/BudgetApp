public struct BudgetPair: Hashable, Sendable {
    public let limit: Double
    public let used: Double
    
    public init(limit: Double, used: Double) {
        self.limit = limit
        self.used = used
    }
}


public extension BudgetPair {
    
    var available: Double {
        limit - used
    }
}
