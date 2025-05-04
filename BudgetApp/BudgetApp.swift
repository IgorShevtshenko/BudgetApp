import SwiftUI
import BudgetFeature
import BudgetServiceImpl

@main
struct BudgetApp: App {
    
    @StateObject private var viewModel: BudgetOverviewViewModel = .init(
        dependencies: .init(budgetService: BudgetServiceImpl()),
        reduce: BudgetOverviewReducer.reduce
    )
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                BudgetOverviewView(viewModel: viewModel) { routing in
                    switch routing {
                    case .spendingCategoryDetails(let category):
                        SpendingCategoryDetailsView(
                            viewModel: SpendingCategoryDetailsViewModel(
                                category: category,
                                dependencies: .init(budgetService: BudgetServiceImpl()),
                                reduce: SpendingCategoryDetailsReducer.reduce
                            )
                        )
                    }
                }
            }
        }
    }
}
