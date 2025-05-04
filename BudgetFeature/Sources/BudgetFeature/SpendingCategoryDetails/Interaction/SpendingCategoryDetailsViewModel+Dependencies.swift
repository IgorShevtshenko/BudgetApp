import BudgetService

public extension SpendingCategoryDetailsViewModel {
    
    struct Dependencies {
        let budgetService: BudgetService
        
        public init(budgetService: BudgetService) {
            self.budgetService = budgetService
        }
    }
}
