import Domain

public struct BudgetOverview: Equatable {
    public let budget: BudgetPair
    public let spendingCategories: [SpendingCategory]
}

public struct BudgetOverviewState {
    var budgetOverviewState: BudgetOverviewState = .loading
    var selectedSpendingCategory: SpendingCategory?
}

public extension BudgetOverviewState {
    
    enum BudgetOverviewState: Equatable {
        case success(BudgetOverview)
        case failure(BudgetOverviewError)
        case loading
    }
    
    enum BudgetOverviewError: Error {
        case general
    }
}
