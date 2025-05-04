public enum BudgetOverviewReducer {
    
    static func reduce(
        state: BudgetOverviewState,
        event: BudgetOverviewEvent
    ) -> BudgetOverviewState {
        var state = state
        switch event {
        case .didFetchBudgetOverview(let budgetOverview):
            state.budgetOverviewState = .success(budgetOverview)
            
        case .didFailFetchingBudgetOverview(let error):
            state.budgetOverviewState = .failure(error)
            
        case .didStartLoadingBudgetOverview:
            state.budgetOverviewState = .loading
            
        case .didChangeSelectedSpendingCategory(let category):
            state.selectedSpendingCategory = category
        }
        return state
    }
}
