import RxSwift
import RxSwiftExt
import Library
import Firebase
import Himotoki

extension Firebase {
    struct Reaction: ReactionType {
        let id: ReactionID

        let author: UserID
        let post: PostID
        let content: String

        static func fromFirebase(_ snapshot: DataSnapshot) -> Firebase.Reaction? {
            guard let json = snapshot.value as? [String: Any] else { return .none }

            return try? Firebase.Reaction.decodeValue(json.embed(uid: snapshot.key))
        }

        static func fromFirebase(_ snapshot: DataSnapshot) throws -> [Firebase.Reaction] {
            return snapshot.children.map { reactionSnapshot in
                Reaction.fromFirebase(reactionSnapshot as! DataSnapshot)!
            }
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
    func reaction(withId id: ReactionID) -> Observable<Firebase.Reaction?> {
        return ref
            .child("reactions")
            .child(id)
            .rx.observeEventOnce()
            .map(Firebase.Reaction.decodeValue)
    }

    func reactions(forPost postId: PostID) -> Observable<[Firebase.Reaction]> {
        return ref
            .child("reactions")
            .child(postId)
            .rx.observeEventOnce()
            .map(Firebase.Reaction.fromFirebase)
    }

    func createReaction(content: String, on post: PostID, by author: UserID) -> Observable<Firebase.Reaction> {
        return ref
            .child("reactions")
            .rx.setChildByAutoId([
                "content": content,
                "postId": post,
                "authorId": author
            ])
            .map { ref in Firebase.Reaction(id: ref.key, author: author, post: post, content: content) }
    }

    func updateReaction(_ id: ReactionID, newContent: String) -> Observable<String> {
        return ref
            .child("reactions")
            .child(id)
            .child("content")
            .rx.setValue(newContent)
            .mapTo(newContent)
    }

    func deleteReaction(withID id: ReactionID) -> Observable<Void> {
        return ref
            .child("reactions")
            .child(id)
            .rx.setValue(.none)
            .mapTo(())
    }
}
