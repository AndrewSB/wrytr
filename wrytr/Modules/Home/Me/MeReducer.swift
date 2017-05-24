import ReSwift

extension Me {
    class State {}

    enum Action: ReSwift.Action {}
}

extension Me {
    static var reduce: Reducer<Me.State> {
        return { action, state in
            return state ?? Me.State()
        }
    }
}
