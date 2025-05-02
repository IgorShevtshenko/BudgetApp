import Domain

public struct BudgetOverviewPayload: Equatable {
    public let budget: BudgetPair
    public let spendingCategories: [SpendingCategory]
}

public struct BudgetOverviewState {
    var budgetOverviewState: BudgetOverviewState = .loading
}

extension BudgetOverviewState {
    
    enum BudgetOverviewState: Equatable {
        case success(BudgetOverviewPayload)
        case failure(BudgetOverviewError)
        case loading
    }
    
    enum BudgetOverviewError: Error {
        case general
    }
}
