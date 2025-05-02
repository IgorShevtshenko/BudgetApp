import Combine
import Foundation

open class ViewModel<State, Action>: ObservableObject {
    
    public typealias State = State
    public typealias Action = Action

    @Published public private(set) var state: State

    private var cancellables = Set<AnyCancellable>()

    public init<Event, EventPublisher: Publisher>(
        initial: State,
        dataEvents: EventPublisher,
        reducer: @escaping (State, Event) -> State
    ) where EventPublisher.Output == Event, EventPublisher.Failure == Never {
        state = initial
        dataEvents
            .scan(initial, reducer)
            .prepend(initial)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in self?.state = $0 })
            .store(in: &cancellables)
    }

    public init(constantState: State) {
        state = constantState
    }

    open func send(_ action: Action) {}
}
