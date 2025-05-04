import SwiftUI
import ArchitectureKit

public struct SpendingCategoryDetailsView: View {
    
    @ObservedObject private var viewModel: ViewModel<
        SpendingCategoryDetailsState, SpendingCategoryDetailsAction
    >
    
    public init(viewModel: ViewModel<SpendingCategoryDetailsState, SpendingCategoryDetailsAction>) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ZStack {
            switch viewModel.state.transactionsState {
            case .success(let transactions):
                ScrollView {
                    LazyVStack(alignment: .center, spacing: 32) {
                        header
                            .safeAreaPadding(.horizontal, 40)
                        SpendingCategoryChart(
                            transactions: viewModel.state.chartPayloads(from: transactions)
                        )
                        
                        TransactionsList(transactions: transactions)
                    }
                    .safeAreaPadding(20)
                }
                .refreshable {
                    viewModel.send(.refresh)
                }
                
            case .failure(let error):
                FailureView(error: description(for: error)) {
                    viewModel.send(.fetchTransactions)
                }
                
            case .loading:
                ProgressView()
                    .progressViewStyle(.circular)
            }
        }
        .transition(.opacity)
        .animation(.default, value: viewModel.state.transactionsState)
        .navigationTitle(viewModel.state.category.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var header: some View {
        HStack(alignment: .center, spacing: 0) {
            VStack(alignment: .center, spacing: 4) {
                Text("Spent")
                    .font(.title2)
                Text(viewModel.state.category.budget.used.monetary)
                    .font(.title.bold())
            }
            
            Spacer()
            
            VStack(alignment: .center, spacing: 4) {
                Text("Left")
                    .font(.title2)
                Text(viewModel.state.category.budget.available.monetary)
                    .font(.title.bold())
            }
        }
    }
}

private extension SpendingCategoryDetailsView {
    
    func description(
        for error: SpendingCategoryDetailsState.SpendingCategoryDetailsError
    ) -> String {
        switch error {
        case .general:
            "Something went wrong"
        }
    }
}

#Preview("Success") {
    SpendingCategoryDetailsView(
        viewModel: .init(
            constantState: .init(
                category: .init(id: "1", name: "Food", budget: .init(limit: 100, used: 50)),
                transactionsState: .success(
                    [
                        .init(id: "1", merchant: "Grocery Store", amount: 50),
                        .init(id: "2", merchant: "Grocery Store", amount: 35),
                        .init(id: "3", merchant: "Restaurant", amount: 100),
                        .init(id: "4", merchant: "Pizza", amount: 15),
                    ]
                )
            )
        )
    )
}

#Preview("Failure") {
    SpendingCategoryDetailsView(
        viewModel: .init(
            constantState: .init(
                category: .init(id: "1", name: "Food", budget: .init(limit: 100, used: 50)),
                transactionsState: .failure(.general)
            )
        )
    )
}

#Preview("Loading") {
    SpendingCategoryDetailsView(
        viewModel: .init(
            constantState: .init(
                category: .init(id: "1", name: "Food", budget: .init(limit: 100, used: 50)),
                transactionsState: .loading
            )
        )
    )
}
