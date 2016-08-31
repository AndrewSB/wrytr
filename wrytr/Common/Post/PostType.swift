typealias PostID = String

protocol PostType {
    var id: PostID { get }
    var prompt: String { get }
    
    var authorId: UserID { get }
    var reactions: [ReactionType] { get }
}
