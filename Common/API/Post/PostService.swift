import Firebase
import RxSwift
import RxSwiftExt

extension Post {

    class Service {
        fileprivate static let 🔥 = Firebase.Provider.shared // swiftlint:disable:this variable_name
    }
    
}

extension Post.Service {
    static func post(withID id: PostID) -> Observable<PostType> {
        return 🔥.fetchPost(withId: id).map {
            switch $0 {
            case .none:             throw API.Error.resourceDNE
            case .some(let post):   return post as PostType
            }
        }
    }
    
    static func getNewPosts() -> Observable<[PostType]> {
        return 🔥.fetchPosts().map { firebasePosts in firebasePosts.map { $0 as PostType } }
    }
    
    static func createPost(prompt: String, by user: UserID) -> Observable<PostType> {
        return 🔥.createPost(prompt: prompt, by: user).map { $0 as PostType }
    }
}

extension Post.Service {
    static func reactionsForPost(withID id: PostID) -> Observable<[ReactionType]> {
        return 🔥.reactions(forPost: id).map { reactions in reactions.map { $0 as ReactionType } }
    }
    
    static func reaction(withID id: ReactionID) -> Observable<ReactionType> {
        return 🔥.reaction(withId: id).map {
            switch $0 {
            case .none:                 throw API.Error.resourceDNE
            case .some(let reaction):   return reaction as ReactionType
            }
        }
    }
    
    static func react(toPost post: PostID, content: String, user: UserID) -> Observable<ReactionType> {
        return 🔥.createReaction(content: content, on: post, by: user).map { $0 as ReactionType }
    }
    
    enum ReactionChange {
        case delete
        case newContent(String)
    }

    static func deleteReaction(_ id: ReactionID) -> Observable<Void> {
        return 🔥.deleteReaction(withID: id)
    }

    static func updateReaction(_ id: ReactionID, newContent: String) -> Observable<ReactionType> {
        return self.reaction(withID: id)
            .flatMap { oldReaction in
                🔥.updateReaction(id, newContent: newContent).map { (oldReaction, $0) }
            }
            .map { oldReaction, newContent in
                Firebase.Reaction(
                    id: oldReaction.id,
                    author: oldReaction.author,
                    post: oldReaction.post,
                    content: newContent
                )
            }
    }
}
