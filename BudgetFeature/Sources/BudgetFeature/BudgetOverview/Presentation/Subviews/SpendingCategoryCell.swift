import SwiftUI
import Domain

public struct SpendingCategoryCell: View {
    
    public var category: SpendingCategory
    
    public var body: some View {
        HStack(alignment: .center, spacing: 26) {
            VStack(alignment: .leading, spacing: 12) {
                Text(category.name)
                    .font(.title2.bold())
                ProgressView(value: category.budget.used, total: category.budget.limit)
                    .progressViewStyle(.linear)
            }
            VStack(alignment: .trailing, spacing: 2) {
                Text(category.budget.limit.monetary)
                    .font(.title3.bold())
                Text("Left \(category.budget.available.monetary)")
                    .font(.body)
            }
        }
    }
}

#Preview {
    SpendingCategoryCell(
        category: .init(
            name: "Food",
            budget: .init(limit: 1000, used: 744.30)
        )
    )
}
