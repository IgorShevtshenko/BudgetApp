import BudgetService

public extension BudgetOverviewViewModel {
    
    struct Dependencies {
        let budgetService: BudgetService
        
        init(budgetService: BudgetService) {
            self.budgetService = budgetService
        }
    }
}
