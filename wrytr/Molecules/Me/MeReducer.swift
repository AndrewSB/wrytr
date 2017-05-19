import ReSwift

extension Me {
    class State {}

    enum Action: ReSwift.Action {}
}

extension Me {
    var reducer: Reducer<App.State> {
        return { action, state in
            fatalError("to be implemented")
        }
    }
}
