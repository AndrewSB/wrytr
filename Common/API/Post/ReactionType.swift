protocol ReactionType {
    var author: UserID { get }
    var post: PostID { get }
    var content: String { get }
}
