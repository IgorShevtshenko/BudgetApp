import SwiftUI
import Domain

struct TransactionsList: View {
    
    private let transactions: [Domain.Transaction]
    
    init(transactions: [Domain.Transaction]) {
        self.transactions = transactions
    }
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 8) {
            ForEach(transactions) { transaction in
                TransactionCell(transaction: transaction)
            }
        }
        .primaryBackground(alignment: .leading)
    }
}

private struct TransactionCell: View {
    
    private let transaction: Domain.Transaction
    
    init(transaction: Domain.Transaction) {
        self.transaction = transaction
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            VStack(alignment: .leading, spacing: 2) {
                Text(transaction.merchant)
                    .font(.body)
                Text(transaction.amount.monetary)
                    .font(.headline.bold())
            }
            Spacer()
            Image(systemName: "chevron.right")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundStyle(.gray)
        }
        .padding(.vertical, 6)
    }
}
