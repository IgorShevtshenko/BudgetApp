import BudgetService
import Domain

public struct BudgetServiceImpl: BudgetService {
    
    public init() {}
    
    public func getBudget() async throws(GetBudgetError) -> BudgetPair {
        try? await Task.sleep(for: .seconds(1))
        let limit = Double.random(in: 150...1000)
        let used = Double.random(in: 0...limit)
        return BudgetPair(limit: limit, used: used)
    }
    
    public func getSpendingCategories() async throws(
        GetSpendingCategoriesError
    ) -> [SpendingCategory] {
        try? await Task.sleep(for: .seconds(1))
        let foodLimit = Double.random(in: 0...500)
        let shoppingLimit = Double.random(in: 0...500)
        let travelLimit = Double.random(in: 0...500)
        return [
            .init(
                id: "1",
                name: "Food",
                budget: .init(limit: foodLimit, used: Double.random(in: 0...foodLimit))
            ),
            .init(
                id: "2",
                name: "Shopping",
                budget: .init(limit: shoppingLimit, used: Double.random(in: 0...shoppingLimit))
            ),
            .init(
                id: "3",
                name: "Travel",
                budget: .init(limit: travelLimit, used: Double.random(in: 0...travelLimit))
            )
        ]
    }
}
