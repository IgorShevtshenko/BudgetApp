import Domain

public struct SpendingCategoryDetailsState {
    let category: SpendingCategory
    var transactionsState: TransactionsState = .loading
}

extension SpendingCategoryDetailsState {
    
    public enum TransactionsState: Equatable {
        case success([Transaction])
        case failure(SpendingCategoryDetailsError)
        case loading
    }
    
    public enum SpendingCategoryDetailsError: Error {
        case general
    }
    
    func chartPayloads(from transactions: [Transaction]) -> [ChartPayload] {
        transactions.reduce(into: [ChartPayload]()) { payloads, transaction in
            guard let payload = payloads.first(
                where: { $0.merchant == transaction.merchant }
            )
            else {
                payloads.append(.init(merchant: transaction.merchant, amount: transaction.amount))
                return
            }
            let mergedPayload = ChartPayload(
                merchant: transaction.merchant,
                amount: payload.amount + transaction.amount
            )
            payloads.removeAll { $0.merchant == mergedPayload.merchant }
            payloads.append(mergedPayload)
        }
    }
}
