import Testing
import Domain
@testable import BudgetFeature

struct BudgetOverviewReducerTests {

    @Test("budgetOverviewState set to success")
    func testDidFetchBudgetOverview() async throws {
        let expectedBudgetOverview = BudgetOverview(
            budget: .init(limit: 100, used: 50),
            spendingCategories: []
        )
        let state = BudgetOverviewReducer.reduce(
            state: .init(),
            event: .didFetchBudgetOverview(expectedBudgetOverview)
        )
        #expect(state.budgetOverviewState == .success(expectedBudgetOverview))
    }

    @Test("budgetOverviewState set to failure")
    func testDidFailFetchingBudgetOverview() async throws {
        let state = BudgetOverviewReducer.reduce(
            state: .init(),
            event: .didFailFetchingBudgetOverview(.general)
        )
        #expect(state.budgetOverviewState == .failure(.general))
    }
    
    @Test("budgetOverviewState set to loading")
    func testDidStartLoadingBudgetOverview() async throws {
        let state = BudgetOverviewReducer.reduce(
            state: .init(),
            event: .didStartLoadingBudgetOverview
        )
        #expect(state.budgetOverviewState == .loading)
    }
    
    @Test("selectedSpendingCategory set to sent category")
    func testDidChangeSelectedSpendingCategory() async throws {
        let expectedCategory = SpendingCategory(
            id: "1",
            name: "Food",
            budget: .init(limit: 100, used: 50)
        )
        let state = BudgetOverviewReducer.reduce(
            state: .init(),
            event: .didChangeSelectedSpendingCategory(expectedCategory)
        )
        #expect(state.selectedSpendingCategory == expectedCategory)
    }
}
