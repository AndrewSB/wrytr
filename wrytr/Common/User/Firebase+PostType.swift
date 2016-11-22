import RxSwift
import RxCocoa
import Firebase
import Himotoki

extension Firebase {

    struct Post: PostType {
        let id: PostID
        let prompt: String

        let author: UserID
        fileprivate var internalReactions: [Reaction]

        var reactions: [ReactionType] { return internalReactions.map { $0 as ReactionType } }
    }

    struct Reaction: ReactionType {
        let author: UserID
        let post: PostID
        let content: String
    }
}

extension Firebase.Post: Decodable {
    static func decode(_ e: Extractor) throws -> Firebase.Post { //swiftlint:disable:this variable_name
        let r: [Firebase.Reaction] = (try e <||? "reactons") ?? []

        return try Firebase.Post(
            id: e <| "uid",
            prompt: e <| "prompt",
            author: e <| "userId",
            internalReactions: r
        )
    }
}

extension Firebase.Reaction: Decodable {
    static func decode(_ e: Extractor) throws -> Firebase.Reaction { //swiftlint:disable:this variable_name
        return try Firebase.Reaction(
            author: e <| "authorId",
            post: e <| "postId",
            content: e <| "content"
        )
    }
}

extension Reactive where Base: Firebase {

    func fetchPosts() -> Observable<[Firebase.Post]> {
        return self.base
            .child(byAppendingPath: "posts")
            .queryOrdered(byChild: "date")
            .rx.observeEventOnce()
            .map { arrayOfPostData -> Array<[String: AnyObject]> in
                guard let json = arrayOfPostData.value as? [String : AnyObject] else {
                    // assume empty
                    return []
                }

                let dictionariesWithUIDIncluded = json.map { (key, val) -> [String: AnyObject] in
                    guard var innerJSON = val as? [String: AnyObject] else {
                        assertionFailure(); return [:]
                    }

                    innerJSON["uid"] = key as AnyObject
                    return innerJSON
                }

                return dictionariesWithUIDIncluded
            }.flatMap { json -> Observable<[Firebase.Post]> in
                do {
                    return .just(try Array<Firebase.Post>.decode(json))
                } catch { return .error(error) }
            }
    }

}
