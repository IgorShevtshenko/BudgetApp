public enum SpendingCategoryDetailsReducer {
    
    public static func reduce(
        state: SpendingCategoryDetailsState,
        event: SpendingCategoryDetailsEvent
    ) -> SpendingCategoryDetailsState {
        var state = state
        switch event {
        case .didFetchTransactions(let transactions):
            state.transactionsState = .success(transactions)
            
        case .didFailFetchingTransactions(let error):
            state.transactionsState = .failure(error)
            
        case .didStartLoadingTransactions:
            state.transactionsState = .loading
        }
        return state
    }
}
