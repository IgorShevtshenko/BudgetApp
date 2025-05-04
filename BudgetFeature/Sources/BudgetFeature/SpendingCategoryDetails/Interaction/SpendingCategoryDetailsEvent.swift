import Domain

public enum SpendingCategoryDetailsEvent {
    case didFetchTransactions([Transaction])
    case didFailFetchingTransactions(SpendingCategoryDetailsState.SpendingCategoryDetailsError)
    case didStartLoadingTransactions
}
