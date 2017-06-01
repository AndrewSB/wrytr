import Firebase
import RxSwift
import RxCocoa
import TwitterKit

class Firebase {

    class Provider {
        internal let ref: DatabaseReference // swiftlint:disable:this variable_name

        init() {
            FirebaseApp.configure()
            self.ref = Database.database().reference()
        }

        var isLoggedIn: Bool {
            return Auth.auth().currentUser != nil
        }

        var authUser: User? {
            return Auth.auth().currentUser.map(Firebase.User.init(firebaseUser:))
        }

        static let shared = Provider()
    }

}

extension Firebase.Provider {
    func login(email: String, password: String) -> Observable<Firebase.User> {
        return Auth.auth().rx
            .login(email: email, password: password)
            .map(Firebase.User.init(firebaseUser:))
    }

    func signup(name: String, email: String, password: String) -> Observable<Firebase.User> {
        return Auth.auth().rx
            .signup(email: email, password: password)
            .map { firebaseUser in
                return Firebase.User(id: firebaseUser.uid, name: name, photo: .none)
            }
    }
}
