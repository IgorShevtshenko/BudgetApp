import Domain

public enum BudgetOverviewAction {
    case showSpendingCategoryDetails(SpendingCategory)
    case cancelSpendingCategoryDetails
    case fetchBudgetOverview
}
