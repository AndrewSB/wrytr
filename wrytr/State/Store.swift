import ReSwift

public typealias DefaultStore = Store<AppState>

extension DefaultStore {
    static func create() -> DefaultStore {
        return Store(reducer: appReducer, state: .none)
    }
}

fileprivate let appReducer = CombinedReducer([
    Authentication.Reducer(),
    Post.Reducer(),
    viewModelReducers
])

fileprivate let viewModelReducers = CombinedReducer([
    Landing.Reducer(),
    Feed.Reducer(),
    Friends.Reducer(),
    Create.Reducer(),
    Me.Reducer()
    ])
