import ReSwift
import ReSwiftRouter

struct SelectPostAction: Action {
    let post: InflatedPost?
    let displayState: PostDetailViewController.DisplayState?
}