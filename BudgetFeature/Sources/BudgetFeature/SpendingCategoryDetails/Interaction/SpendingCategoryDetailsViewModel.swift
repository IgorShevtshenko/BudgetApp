import ArchitectureKit
import Combine
import BudgetService
import Domain

public final class SpendingCategoryDetailsViewModel: ViewModel<
    SpendingCategoryDetailsState, SpendingCategoryDetailsAction
> {
    
    private let events = PassthroughSubject<SpendingCategoryDetailsEvent, Never>()
    
    private var task: Task<Void, Never>?
    
    private let dependencies: Dependencies
    
    public init(
        category: SpendingCategory,
        dependencies: Dependencies,
        prepenendActions: [SpendingCategoryDetailsAction] = [.fetchTransactions],
        reduce: @escaping (State, SpendingCategoryDetailsEvent) -> State
    ) {
        self.dependencies = dependencies
        
        super.init(
            initial: .init(category: category),
            dataEvents: events,
            reducer: reduce
        )
        
        prepenendActions.forEach { action in
            send(action)
        }
    }
    
    override public func send(_ action: SpendingCategoryDetailsAction) {
        switch action {
        case .fetchTransactions:
            events.send(.didStartLoadingTransactions)
            task = fetchBudgetOverview()
        case .refresh:
            task = fetchBudgetOverview()
        }
    }
    
    private func fetchBudgetOverview() -> Task<Void, Never> {
        Task { [dependencies] in
            do throws(SpendingCategoryDetailsState.SpendingCategoryDetailsError) {
                let transactions = try await dependencies.budgetService.transactions(
                    for: state.category.id
                )
                events.send(.didFetchTransactions(transactions))
            } catch {
                events.send(.didFailFetchingTransactions(error))
            }
        }
    }
}

private extension BudgetService {
    
    func transactions(
        for categoryId: String) async throws(SpendingCategoryDetailsState.SpendingCategoryDetailsError
    ) -> [Transaction] {
        do {
            return try await getTransactions(for: categoryId)
        } catch {
            throw SpendingCategoryDetailsState.SpendingCategoryDetailsError(from: error)
        }
    }
}

private extension SpendingCategoryDetailsState.SpendingCategoryDetailsError {
    
    init(from error: GetSpendingCategoryTransactionsError) {
        switch error {
        case .general:
            self = .general
        }
    }
}
