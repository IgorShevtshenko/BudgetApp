import BudgetService

public extension BudgetOverviewViewModel {
    
    struct Dependencies {
        let budgetService: BudgetService
        
        public init(budgetService: BudgetService) {
            self.budgetService = budgetService
        }
    }
}
