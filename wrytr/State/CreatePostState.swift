import Foundation

import Result

import ReSwift

struct CreatePostState {
    var toBeUploaded: Post?
    var didUpload: Result<Post, NSError>?
}
