import Domain

public enum BudgetOverviewEvent: Equatable {
    case didFetchBudgetOverview(BudgetOverview)
    case didFailFetchingBudgetOverview(BudgetOverviewState.BudgetOverviewError)
    case didStartLoadingBudgetOverview
    case didChangeSelectedSpendingCategory(SpendingCategory?)
}
