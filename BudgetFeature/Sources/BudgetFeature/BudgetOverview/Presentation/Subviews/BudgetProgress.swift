import SwiftUI
import Domain

struct BudgetProgress: View {
    
    private let budget: BudgetPair
    
    init(budget: BudgetPair) {
        self.budget = budget
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            HStack(alignment: .top, spacing: 0) {
                progressComponent(title: "Left to spend", amount: budget.available)
                Spacer()
                progressComponent(title: "Monthly budget", amount: budget.limit)
            }
            
            ProgressView(value: budget.available, total: budget.limit)
        }
        .primaryBackground()
    }
    
    func progressComponent(title: String, amount: Double) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.headline)
                .foregroundStyle(Color.gray)
            Text(amount.monetary)
                .font(.title3.bold())
        }
    }
}

#Preview {
    BudgetProgress(budget: .init(limit: 1000, used: 439.15))
}
