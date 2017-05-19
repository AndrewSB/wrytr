import Foundation
import ReSwift
/**
 A Reducer that combines multiple reducers into one. You will typically use this reducer during
 initial store setup:
 ```swift
 let reducer = CombinedReducer([IncreaseByOneReducer(), IncreaseByTwoReducer()])
 Store(reducer: reducer, appState: CounterState())
 ```
 The order of the reducers in the array is the order in which the reducers will be invoked.
 */
public struct CombinedReducer: AnyReducer {

    private let reducers: [AnyReducer]

    /// Creates a Combined Reducer from the given list of Reducers
    public init(_ reducers: [AnyReducer]) {
        precondition(!reducers.isEmpty)

        self.reducers = reducers
    }

    // swiftlint:disable:next identifier_name
    public func _handleAction(_ action: Action, state: StateType) -> StateType {
        return reducers.reduce(state) { (currentState, reducer) -> StateType in
            return reducer._handleAction(action, state: currentState)
        }
    }
}
