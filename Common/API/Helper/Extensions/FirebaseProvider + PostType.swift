import RxSwift
import RxCocoa
import RxSwiftExt
import Firebase
import Himotoki

extension Firebase {

    struct Post: PostType {
        let id: PostID
        let prompt: String

        let author: UserID
    }

    struct Reaction: ReactionType {
        let id: ReactionID

        let author: UserID
        let post: PostID
        let content: String
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

extension Firebase.Reaction: Decodable {
    static func decode(_ e: Extractor) throws -> Firebase.Reaction { //swiftlint:disable:this variable_name
        return try Firebase.Reaction(
            id: e <| "uid",
            author: e <| "authorId",
            post: e <| "postId",
            content: e <| "content"
        )
    }

    // doesnt include the id, since we never want to upload that. The ID is simply the location
    func encoded() -> [String: Any] {
        return [
            "authorId": author,
            "postId": post,
            "content": content
        ]
    }
}

extension Firebase.Provider {

    func fetchPosts() -> Observable<[Firebase.Post]> {
        return ref
            .child(byAppendingPath: "posts")
            .queryOrdered(byChild: "date")
            .rx.observeEventOnce()
            .map { arrayOfPostData -> [[String: AnyObject]] in
                guard let json = arrayOfPostData.value as? [String : AnyObject] else {
                    // assume empty if doesn't cast
                    return []
                }

                let dictionariesWithUIDIncluded = json.map { (key, val) -> [String: AnyObject] in
                    guard var innerJSON = val as? [String: AnyObject] else {
                        fatalError()
                    }

                    innerJSON["uid"] = key as AnyObject
                    return innerJSON
                }

                return dictionariesWithUIDIncluded
            }
            .map(Array<Firebase.Post>.decode)
    }

    func createPost(prompt: String, by userId: UserID) -> Observable<Firebase.Post> {
        return ref
            .child(byAppendingPath: "posts")
            .rx.setChildByAutoId([
                "prompt": prompt,
                "author": userId
            ])
            .map { ref in Firebase.Post(id: ref.key, prompt: prompt, author: userId) }
    }

    func createReaction(content: String, on post: PostID, by author: UserID) -> Observable<Firebase.Reaction> {
        return ref
            .child(byAppendingPath: "reactions")
            .rx.setChildByAutoId([
                "content": content,
                "postId": post,
                "authorId": author
            ])
            .map { ref in Firebase.Reaction(id: ref.key, author: author, post: post, content: content) }
    }

    func updateReaction(_ id: ReactionID, newContent: String) -> Observable<String> {
        return ref
            .child(byAppendingPath: "reactions")
            .child(byAppendingPath: id)
            .child(byAppendingPath: "content")
            .rx.setValue(NSString(string: newContent))
            .mapTo(newContent)
    }
    
    func deleteReaction(withID id: ReactionID) -> Observable<Void> {
        return ref
            .child(byAppendingPath: "reactions")
            .child(byAppendingPath: id)
            .rx.setValue(.none)
            .mapTo(())
    }
}
