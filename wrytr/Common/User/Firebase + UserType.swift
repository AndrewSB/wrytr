import Firebase
import RxSwift
import RxCocoa

extension Firebase {
    struct User: UserType {
        let id: UserID
        let name: String
        let photo: URL?
    }
}

extension Reactive where Base: Firebase {
    
    func fetchUser(withId id: UserID) -> Observable<Firebase.User> {
        return .empty()
    }
    
}
