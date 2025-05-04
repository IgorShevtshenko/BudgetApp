import SwiftUI
import Domain
import Charts

struct ChartPayload {
    let merchant: String
    let amount: Double
}

struct SpendingCategoryChart: View {
    private let transactions: [ChartPayload]
    
    init(transactions: [ChartPayload]) {
        self.transactions = transactions
    }
    
    var body: some View {
        Chart(transactions, id: \.merchant) { transaction in
            SectorMark(
                angle: .value("Merchant", transaction.amount),
                innerRadius: .ratio(0.6),
                angularInset: 3
            )
            .cornerRadius(5)
            .foregroundStyle(by: .value("Merchant", transaction.merchant))
        }
        .frame(height: 200)
        .chartLegend(position: .bottom, alignment: .center, spacing: 16)
    }
}

#Preview {
    SpendingCategoryChart(
        transactions: [
            .init(merchant: "Grocery Store", amount: 50),
            .init(merchant: "Restaurant", amount: 100),
            .init(merchant: "Pizza", amount: 15),
        ]
    )
}
