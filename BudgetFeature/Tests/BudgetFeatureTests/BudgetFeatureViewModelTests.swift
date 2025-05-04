import Testing
import BudgetService
import Domain
@testable import BudgetFeature

@MainActor
struct BudgetFeatureViewModelTests {
    
    @Test("Test choose category")
    func testShowSpendingCategoryDetails() async throws {
        let expectedCategory = SpendingCategory(
            name: "Food",
            budget: .init(limit: 100, used: 50)
        )
        await confirmation { confirmation in
            let viewModel = makeViewModel { event in
                if event == .didChangeSelectedSpendingCategory(expectedCategory) {
                    confirmation.confirm()
                }
            }
            viewModel.send(.showSpendingCategoryDetails(expectedCategory))
        }
    }
    
    @Test("Test cancel category details")
    func testCancelSpendingCategoryDetails() async throws {
        await confirmation { confirmation in
            let viewModel = makeViewModel { event in
                if event == .didChangeSelectedSpendingCategory(nil) {
                    confirmation.confirm()
                }
            }
            viewModel.send(.cancelSpendingCategoryDetails)
        }
    }
    
    @Test("Test fetch budget overview success")
    func testFetchBudgetOverviewSuccess() async throws {
        await confirmation { confirmation in
            let expectedEvents = [
                BudgetOverviewEvent.didStartLoadingBudgetOverview,
                .didFetchBudgetOverview(
                    .init(
                        budget: .init(limit: 100, used: 50),
                        spendingCategories: [
                            .init(name: "Food", budget: .init(limit: 100, used: 50))
                        ]
                    )
                )
            ]
            var events: [BudgetOverviewEvent] = []
            let viewModel = makeViewModel { event in
                events.append(event)
                guard events.count == expectedEvents.count else { return }
                if events == expectedEvents {
                    confirmation.confirm()
                }
            }
            viewModel.send(.fetchBudgetOverview)
            try? await Task.sleep(for: .seconds(0.1))
        }
    }
    
    @Test("Test fetch budget overview failure")
    func testFetchBudgetOverviewFailure() async throws {
        await confirmation { confirmation in
            let expectedEvents = [
                BudgetOverviewEvent.didStartLoadingBudgetOverview,
                .didFailFetchingBudgetOverview(.general)
            ]
            var events: [BudgetOverviewEvent] = []
            let onGetBudget: () async throws(GetBudgetError) -> BudgetPair = { () throws(GetBudgetError) in
                throw GetBudgetError.general
            }
            let viewModel = makeViewModel(onGetBudget: onGetBudget) { event in
                events.append(event)
                guard events.count == expectedEvents.count else { return }
                if events == expectedEvents {
                    confirmation.confirm()
                }
            }
            viewModel.send(.fetchBudgetOverview)
            try? await Task.sleep(for: .seconds(0.1))
        }
    }
    
    private func makeViewModel(
        onGetBudget: @escaping () async throws(GetBudgetError) -> BudgetPair = {
            .init(limit: 100, used: 50)
        },
        onGetSpendingCategories: @escaping () async throws(
            GetSpendingCategoriesError
        ) -> [SpendingCategory] = {
            return [.init(name: "Food", budget: .init(limit: 100, used: 50))]
        },
        onSendEvent: @escaping (BudgetOverviewEvent) -> Void
    ) -> BudgetOverviewViewModel {
        BudgetOverviewViewModel(
            dependencies: .init(
                budgetService: MockBudgetService(
                    onGetBudget: onGetBudget,
                    onGetSpendingCategories: onGetSpendingCategories
                )
            ),
            reduce: { state, event in
                onSendEvent(event)
                return state
            }
        )
    }
}

private class MockBudgetService: BudgetService {
    
    private let onGetBudget: () async throws(GetBudgetError) -> BudgetPair
    private let onGetSpendingCategories: () async throws(
        GetSpendingCategoriesError
    ) -> [SpendingCategory]
    
    init(
        onGetBudget: @escaping () async throws(GetBudgetError) -> BudgetPair,
        onGetSpendingCategories: @escaping () async throws(
            GetSpendingCategoriesError
        ) -> [SpendingCategory]
    ) {
        self.onGetBudget = onGetBudget
        self.onGetSpendingCategories = onGetSpendingCategories
    }
    
    func getBudget() async throws(GetBudgetError) -> BudgetPair {
        try await onGetBudget()
    }
    
    func getSpendingCategories() async throws(GetSpendingCategoriesError) -> [SpendingCategory] {
        try await onGetSpendingCategories()
    }
}
