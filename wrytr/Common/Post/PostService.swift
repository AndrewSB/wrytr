import Firebase
import RxSwift
import RxCocoa

extension Post {

    class Service {
        fileprivate static let 🔥 = Firebase.Provider.shared // swiftlint:disable:this variable_name

        static func getNewPosts() -> Observable<[PostType]> {
            return 🔥.fetchPosts().map { firebasePosts in firebasePosts.map { $0 as PostType } }
        }

    }

}
