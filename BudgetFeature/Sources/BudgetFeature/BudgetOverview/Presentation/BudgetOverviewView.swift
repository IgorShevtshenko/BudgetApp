import SwiftUI
import Domain
import ArchitectureKit

public enum Routing {
    case spendingCategoryDetails(SpendingCategory)
}

public struct BudgetOverviewView<RoutingView: View>: View {
    
    @ObservedObject private var viewModel: ViewModel<BudgetOverviewState, BudgetOverviewAction>
    
    private let view: (Routing) -> RoutingView
    
    public init(
        viewModel: ViewModel<BudgetOverviewState, BudgetOverviewAction>,
        @ViewBuilder view: @escaping (Routing) -> RoutingView
    ) {
        self.viewModel = viewModel
        self.view = view
    }
    
    public var body: some View {
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
                            ForEach(budgetOverview.spendingCategories) { category in
                                Button {
                                    viewModel.send(.showSpendingCategoryDetails(category))
                                } label: {
                                    SpendingCategoryCell(category: category)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .primaryBackground()
                    }
                    .safeAreaPadding(24)
                }
                .refreshable {
                    viewModel.send(.refreshBudgetOverview)
                }
                .navigationDestination(
                    item: Binding(
                        get: { viewModel.state.selectedSpendingCategory },
                        set: { _ in viewModel.send(.cancelSpendingCategoryDetails) }
                    )
                ) { category in
                    view(.spendingCategoryDetails(category))
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
    
    func header(budgetOverview: BudgetOverview) -> some View {
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
                                id: "1",
                                name: "Food",
                                budget: .init(limit: 250, used: 123)
                            ),
                            .init(
                                id: "2",
                                name: "Shopping",
                                budget: .init(limit: 300, used: 25)
                            ),
                            .init(
                                id: "3",
                                name: "Travel",
                                budget: .init(limit: 450, used: 403)
                            )
                        ]
                    )
                )
            )
        ),
        view: { _ in EmptyView() }
    )
}

#Preview("Failed") {
    BudgetOverviewView(
        viewModel: .init(
            constantState: .init(
                budgetOverviewState: .failure(.general)
            ),
        ),
        view: { _ in EmptyView() }
    )
}

#Preview("Loading") {
    BudgetOverviewView(
        viewModel: .init(
            constantState: .init(
                budgetOverviewState: .loading
            )
        ),
        view: { _ in EmptyView() }
    )
}
