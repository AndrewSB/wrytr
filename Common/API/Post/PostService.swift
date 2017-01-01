import Firebase
import RxSwift
import RxOptional
import RxSwiftExt

extension Post {

    class Service {
        fileprivate static let 🔥 = Firebase.Provider.shared // swiftlint:disable:this variable_name
    }
    
}

extension Post.Service {
    static func post(withID id: PostID) -> Observable<PostType?> {
        
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
        
    }
    
    static func reaction(withID id: ReactionID) -> Observable<ReactionType?> {}
    
    static func react(toPost post: PostID, content: String, user: UserID) -> Observable<ReactionType> {
        return 🔥.createReaction(content: content, on: post, by: user).map { $0 as ReactionType }
    }
    
    enum ReactionChange {
        case delete
        case newContent(String)
    }

    static func updateReaction(_ id: ReactionID, newContent: ReactionChange) -> Observable<ReactionType?> {
        switch newContent {
        case .delete:
            return 🔥.deleteReaction(withID: id).mapTo(.none)
        case .newContent(let content):
            return self.reaction(withID: id)
                .catchOnNil { throw API.Error.resourceDNE }
                .flatMap { oldReaction in
                    🔥.updateReaction(id, newContent: content).map { (oldReaction, $0) }
                }
                .map { oldReaction, newContent in
                    return Firebase.Reaction.init(id: oldReaction.id, author: oldReaction.author, post: oldReaction.post, content: oldReaction.content) as ReactionType
                }
        }
    }
}
