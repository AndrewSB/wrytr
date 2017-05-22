typealias PostID = String

protocol PostType {
    var id: PostID { get }
    var prompt: String { get }

    var author: UserID { get }
}

func == (lhs: PostType, rhs: PostType) -> Bool {
    return lhs.id == rhs.id
}

func != (lhs: PostType, rhs: PostType) -> Bool {
    return !(lhs == rhs)
}
