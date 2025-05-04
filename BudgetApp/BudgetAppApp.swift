import SwiftUI
import BudgetFeature
import BudgetServiceImpl

@main
struct BudgetAppApp: App {
    
    @StateObject private var viewModel: BudgetOverviewViewModel = .init(
        dependencies: .init(budgetService: BudgetServiceImpl()),
        reduce: BudgetOverviewReducer.reduce
    )
    var body: some Scene {
        WindowGroup {
            BudgetOverviewView(viewModel: viewModel)
        }
    }
}
