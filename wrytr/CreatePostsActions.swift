import Foundation

import ReSwift

struct LocalPostReady: Action {
    let post: Post
}

struct PostCreationCompleted: Action {
    let post: Post?
    let error: NSError?
}
