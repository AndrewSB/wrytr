extension Create {
    class Handler: HandlerType {
        let store: Store

        init(store: Store) {
            self.store = store
        }
    }
}
