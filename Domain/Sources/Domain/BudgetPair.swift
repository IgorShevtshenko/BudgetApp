public struct BudgetPair: Hashable {
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
