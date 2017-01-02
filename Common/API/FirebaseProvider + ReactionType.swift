import RxSwift
import RxSwiftExt
import RxOptional
import Library
import Firebase
import Himotoki

extension Firebase {
    struct Reaction: ReactionType {
        let id: ReactionID

        let author: UserID
        let post: PostID
        let content: String

        static func fromFirebase(_ snapshot: FDataSnapshot) throws -> [Firebase.Reaction] {
            guard let json = snapshot.value as? [String: Any] else { return [] }

            return try json
                .map { (key, value) -> [String: Any] in
                    let singleReactionJSON = value as! [String: Any]
                    return singleReactionJSON + ["uid": key]
                }
                .map(Reaction.decodeValue)
        }
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
    func reaction(withId id: ReactionID) -> Observable<Firebase.Reaction> {
        return ref
            .child(byAppendingPath: "reactions")
            .child(byAppendingPath: id)
            .rx.observeEventOnce()
            .map(Firebase.Reaction.decodeValue)
    }

    func reactions(forPost postId: PostID) -> Observable<[Firebase.Reaction]> {
        return ref
            .child(byAppendingPath: "reactions")
            .child(byAppendingPath: postId)
            .rx.observeEventOnce()
            .map(Firebase.Reaction.fromFirebase)
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
