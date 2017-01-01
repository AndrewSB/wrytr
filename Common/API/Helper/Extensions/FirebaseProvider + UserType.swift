import Firebase
import RxSwift
import RxCocoa
import Himotoki

extension Firebase {
    struct User: UserType {
        let id: UserID
        let name: String
        let photo: URL?
    }
}

extension Firebase.User: Decodable {
    //swiftlint:disable:next variable_name
    static func decode(_ e: Extractor) throws -> Firebase.User {
        return try Firebase.User(
            id: e <| "uid",
            name: e <| "name",
            photo: try URLTransformer.apply(e <| "profileImageURL")
        )
    }

    func encoded() -> [String: String] {
        var coded = [
            "uid": id,
            "name": name,
        ]
        if let photoUrl = photo {
            coded["profileImageURL"] = photoUrl.absoluteString
        }

        return coded
    }
}

extension Firebase.Provider {

    func fetchUser(withId id: UserID) -> Observable<Firebase.User> {
        return ref.child(byAppendingPath: "users/\(id)")
            .rx.observeEventOnce()
            .map { userData -> [String: AnyObject] in
                guard let json: [String: AnyObject] = userData.value as? [String : AnyObject] else {
                    assertionFailure()
                    return [:]
                }
                return json
            }
            .flatMap { json -> Observable<Firebase.User> in
                do {
                    return .just(try Firebase.User.decodeValue(json))
                } catch { return .error(error) }
            }
    }

    func update(user newUser: Firebase.User) -> Observable<Firebase.User> {
        let firebaseUser = Firebase.User(id: newUser.id, name: newUser.name, photo: newUser.photo)

        return ref.child(byAppendingPath: "users/\(newUser.id)")
            .rx.setValue(firebaseUser.encoded() as AnyObject)
            .map { _ in firebaseUser }
    }

}
