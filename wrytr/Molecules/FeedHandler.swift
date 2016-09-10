extension Feed {

    class Handler: HandlerType {
        let store: Store

        init(store: Store) {
            self.store = store
        }
    }

}
