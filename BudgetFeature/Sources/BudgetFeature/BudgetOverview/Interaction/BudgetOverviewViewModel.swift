import ArchitectureKit
import Combine
import BudgetService
import Domain

public final class BudgetOverviewViewModel: ViewModel<BudgetOverviewState, BudgetOverviewAction> {
    
    private let events = PassthroughSubject<BudgetOverviewEvent, Never>()
    
    private var task: Task<Void, Never>?
    
    private let dependencies: Dependencies
    
    public init(
        dependencies: Dependencies,
        reduce: @escaping (State, BudgetOverviewEvent) -> State
    ) {
        self.dependencies = dependencies
        
        super.init(
            initial: .init(),
            dataEvents: events,
            reducer: reduce
        )
    }
    
    override public func send(_ action: BudgetOverviewAction) {
        switch action {
        case .showSpendingCategoryDetails(let spendingCategory):
            events.send(.didChangeSelectedSpendingCategory(spendingCategory))
            
        case .cancelSpendingCategoryDetails:
            events.send(.didChangeSelectedSpendingCategory(nil))
            
        case .fetchBudgetOverview:
            task = Task { [dependencies] in
                do throws(BudgetOverviewState.BudgetOverviewError) {
                    events.send(.didStartLoadingBudgetOverview)
                    let budget = try await dependencies.budgetService.budget()
                    let spednigCategories = try await dependencies.budgetService.spendingCategories()
                    events.send(
                        .didFetchBudgetOverview(
                            .init(
                                budget: budget,
                                spendingCategories: spednigCategories
                            )
                        )
                    )
                } catch {
                    events.send(.didFailFetchingBudgetOverview(error))
                }
            }
        }
    }
}

private extension BudgetService {
    
    func budget() async throws(BudgetOverviewState.BudgetOverviewError) -> BudgetPair {
        do {
            return try await getBudget()
        } catch {
            throw BudgetOverviewState.BudgetOverviewError(from: error)
        }
    }
    
    func spendingCategories() async throws(
        BudgetOverviewState.BudgetOverviewError
    ) -> [SpendingCategory] {
        do {
            return try await getSpendingCategories()
        } catch {
            throw BudgetOverviewState.BudgetOverviewError(from: error)
        }
    }
}

private extension BudgetOverviewState.BudgetOverviewError {
    
    init(from error: GetBudgetError) {
        switch error {
        case .general:
            self = .general
        }
    }
    
    init(from error: GetSpendingCategoriesError) {
        switch error {
        case .general:
            self = .general
        }
    }
}
