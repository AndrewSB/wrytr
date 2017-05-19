import ReSwift

extension Me {
    class State {}

    enum Action: Action {}
}

extension Me {
    var reducer: Reducer {
        return { action, state in
            fatalError("to be implemented")
        }
    }
}
