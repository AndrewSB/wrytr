import RxSwift
import RxSwiftExt
import Firebase
import Himotoki
import Library

extension Firebase {

    struct Post: PostType {
        let id: PostID
        let prompt: String

        let author: UserID

        static func fromFirebase(ref: FDataSnapshot) -> Post? {
            guard let json = ref.value as? [String: Any] else { return nil }

            return fromFirebase(json: ["uid": ref.key! as Any] + json)
        }

        static func fromFirebase(json: [String: Any]) -> Post? {
            return try? Post.decodeValue(json)
        }
    }

}

extension Firebase.Post: Decodable {
    static func decode(_ e: Extractor) throws -> Firebase.Post { //swiftlint:disable:this variable_name

        return try Firebase.Post(
            id: e <| "uid",
            prompt: e <| "prompt",
            author: e <| "authorId"
        )
    }

    // doesnt include the id, since we never want to upload that. The ID is simply the location
    func encoded() -> [String: Any] {
        return [
            "prompt": prompt,
            "authorId": author
        ]
    }
}

extension Firebase.Provider {
    func fetchPost(withId id: PostID) -> Observable<Firebase.Post?> {
        return ref
            .child(byAppendingPath: "posts")
            .child(byAppendingPath: id)
            .rx.observeEventOnce()
            .map(Firebase.Post.fromFirebase)
    }

    func fetchPosts() -> Observable<[Firebase.Post]> {
        return ref
            .child(byAppendingPath: "posts")
            .queryOrdered(byChild: "date")
            .rx.observeEventOnce()
            .map { arrayOfPostsRef in
                guard let arrayOfPostsInJson = arrayOfPostsRef.value as? [[String: Any]] else {
                    fatalError("rethink this :/")
                }
                return arrayOfPostsInJson.map { Firebase.Post.fromFirebase(json: $0)! }
            }
    }

    func createPost(prompt: String, by userId: UserID) -> Observable<Firebase.Post> {
        /// This idea comes from https://github.com/firebase/quickstart-ios/blob/f0c4be06f9bfe73a4a90116b19ee8f500c24f4c1/database/DatabaseExampleSwift/NewPostViewController.swift#L68
        /// Create new post at /user-posts/$userid/$postid and at
        /// /posts/$postid simultaneously
        ///
        /// /user-posts/$userid/$postid so we can find posts for you & your followers
        /// /posts/$postid so we can find everyone's recent & popular posts

        let postId = ref.child(byAppendingPath: "posts").childByAutoId().key! as PostID
        let post = Firebase.Post.init(id: postId, prompt: prompt, author: userId)

        let globalScopedPost = ref
            .child(byAppendingPath: "posts")
            .child(byAppendingPath: postId)
            .rx.setValue(post.encoded() as AnyObject!)

        let userScopedPost = ref
            .child(byAppendingPath: "user-posts")
            .child(byAppendingPath: userId)
            .child(byAppendingPath: postId)
            .rx.setValue(post.encoded() as AnyObject)

        return Observable.zip(globalScopedPost, userScopedPost) { _, _ in post }
    }

}