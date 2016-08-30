import Foundation

import ReSwift

struct RequestNewPosts: Action {}

struct RequestMyPosts: Action {}

struct UpdatePosts: Action {
    let newPosts: [InflatedPost]?
    let myPosts: [InflatedPost]?
}
