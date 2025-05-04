import Domain

public enum GetBudgetError: Error {
    case general
}

public enum GetSpendingCategoriesError: Error {
    case general
}

public enum GetSpendingCategoryTransactionsError: Error {
    case general
}

public protocol BudgetService {
    func getBudget() async throws(GetBudgetError) -> BudgetPair
    func getSpendingCategories() async throws(GetSpendingCategoriesError) -> [SpendingCategory]
    func getTransactions(
        for categoryId: String
    ) async throws(GetSpendingCategoryTransactionsError) -> [Transaction]
}
