typealias ReactionID = String

protocol ReactionType {
    var id: ReactionID { get }

    var author: UserID { get }
    var post: PostID { get }
    var content: String { get }
}
