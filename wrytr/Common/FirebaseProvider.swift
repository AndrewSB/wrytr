import Firebase
import RxSwift
import RxCocoa

extension Firebase {
    
    class Provider {
        private let ref = Firebase(url: "http://wrytr.firebaseio.com")!
        
        var isLoggedIn: Bool {
            return ref.authData != nil
        }
        
        func login(email: String, password: String) -> Observable<UserType> {
            return ref.rx.login(email: email, password: password)
                .flatMap(self.ref.rx.fetchUser)
                .map { $0 as UserType }
        }
        
        func signup(email: String, password: String) -> Observable<UserType> {
            return ref.rx.signup(email: email, password: password)
                .flatMap(self.ref.rx.fetchUser)
                .map { $0 as UserType }
        }
        
        func getUser(withUserID userID: UserID) -> Observable<UserType> {
            return ref.rx.fetchUser(withId: userID).map { $0 as UserType }
        }
        
        func update(userWithID userID: UserID, newUser: UserType) -> Observable<UserType> {
            return ref.rx.updateUser(userId: userID, newUser: newUser).map { $0 as UserType }
        }
    }
}
