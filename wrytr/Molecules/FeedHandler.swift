extension Feed {
    class Handler {

        static func refreshPosts() {
            store.dispatch(Post.loadPosts())
        }

    }

}
