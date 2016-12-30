import Firebase
import RxSwift
import RxCocoa

extension Post {

    class Service {
        fileprivate static let 🔥 = Firebase.Provider.shared // swiftlint:disable:this variable_name

        static func getNewPosts() -> Observable<[PostType]> {
            return 🔥.fetchPosts().map { firebasePosts in firebasePosts.map { $0 as PostType } }
        }

        static func createPost(prompt: String, by user: UserID) -> Observable<PostType> {
            return 🔥.createPost(prompt: prompt, by: user).map { $0 as PostType }
        }

    }

}
