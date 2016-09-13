extension Feed {

    class Handler: HandlerType {
        let store: Store

        init(store: Store) {
            self.store = store
        }

        func refreshPosts() {
            store.dispatch(Post.loadPosts())
        }
    }

}
