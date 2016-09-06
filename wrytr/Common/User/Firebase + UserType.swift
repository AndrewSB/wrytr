import Firebase
import RxSwift
import RxCocoa
import Runes
import Curry
import Argo

extension Firebase {
    struct User: UserType {
        let id: UserID
        let name: String
        let photo: URL?
    }
}

extension Firebase.User: Decodable {

    public static func decode(_ j: JSON) -> Decoded<Firebase.User> {
        let user = curry(Firebase.User.init)
            <^> j <| "uid"
            <*> j <| "name"
            <*> j <|? "profilePictureUrl"
        
        return user
    }
    
}

extension Reactive where Base: Firebase {
    
    func fetchUser(withId id: UserID) -> Observable<Firebase.User> {
        return self.base
            .child(byAppendingPath: "users/\(id)")
            .rx.observeEventOnce()
            .map {
                let json = Argo.JSON($0.value)
                return Firebase.User.decode(json).value!
            }
    }
    
    func updateUser(userId id: UserID, newUser: UserType) -> Observable<Firebase.User> {
        assert(id == newUser.id)
        
        let firebaseUser = Firebase.User(id: newUser.id, name: newUser.name, photo: newUser.photo)
        
        return self.base
            .child(byAppendingPath: "users/\(id)")
            .rx.setValue("" as AnyObject)
            .map { _ in firebaseUser }
    }
    
}
