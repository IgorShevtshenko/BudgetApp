import SwiftUI
import ArchitectureKit

struct BudgetOverviewView: View {
    
    @ObservedObject private var viewModel: ViewModel<BudgetOverviewState, BudgetOverviewAction>
    
    public init(viewModel: ViewModel<BudgetOverviewState, BudgetOverviewAction>) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            switch viewModel.state.budgetOverviewState {
            case .success(let budgetOverview):
                ScrollView {
                    VStack(alignment: .center, spacing: 20) {
                        VStack(alignment: .center, spacing: 28) {
                            header(budgetOverview: budgetOverview)
                            BudgetProgress(budget: budgetOverview.budget)
                        }
                        LazyVStack(alignment: .center, spacing: 26) {
                            ForEach(budgetOverview.spendingCategories, id: \.self) { category in
                                SpendingCategoryCell(category: category)
                            }
                        }
                        .primaryBackground()
                    }
                    .safeAreaPadding(24)
                }
            case .failure(let error):
                FailureView(error: description(for: error)) {
                    viewModel.send(.fetchBudgetOverview)
                }
            case .loading:
                ProgressView()
                    .progressViewStyle(.circular)
            }
        }
        .transition(.opacity)
        .animation(.default, value: viewModel.state.budgetOverviewState)
        .navigationTitle("Overview")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension BudgetOverviewView {
    
    func description(for error: BudgetOverviewState.BudgetOverviewError) -> String {
        switch error {
        case .general:
            "Something went wrong"
        }
    }
    
    func header(budgetOverview: BudgetOverviewPayload) -> some View {
        VStack(alignment: .center, spacing: 4) {
            Text("This month spent")
                .font(.title3)
                .foregroundStyle(Color.gray)
            Text(budgetOverview.budget.used.monetary)
                .font(.largeTitle.bold())
                .contentTransition(.numericText(value: budgetOverview.budget.used))
        }
    }
}

#Preview("Success") {
    BudgetOverviewView(
        viewModel: .init(
            constantState: .init(
                budgetOverviewState: .success(
                    .init(
                        budget: .init(limit: 1000, used: 500),
                        spendingCategories: [
                            .init(
                                name: "Food",
                                budget: .init(limit: 250, used: 123)
                            ),
                            .init(
                                name: "Shopping",
                                budget: .init(limit: 300, used: 25)
                            ),
                            .init(
                                name: "Travel",
                                budget: .init(limit: 450, used: 403)
                            )
                        ]
                    )
                )
            )
        )
    )
}

#Preview("Failed") {
    BudgetOverviewView(
        viewModel: .init(
            constantState: .init(
                budgetOverviewState: .failure(.general)
            )
        )
    )
}

#Preview("Loading") {
    BudgetOverviewView(
        viewModel: .init(
            constantState: .init(
                budgetOverviewState: .loading
            )
        )
    )
}
