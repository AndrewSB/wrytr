import Firebase
import RxSwift
import RxCocoa
import Himotoki

extension Firebase {
    struct User: UserType {
        let id: UserID
        let name: String
        let photo: URL?

        init(id: UserID, name: String, photo: URL?) {
            self.id = id
            self.name = name
            self.photo = photo
        }

        init(firebaseUser: FirebaseAuth.User) {
            switch firebaseUser.providerData.count {
            case 0:
                /// probably a email password user
                let parsedUser =  try? Firebase.User.decodeValue(firebaseUser.dictionaryWithValues(forKeys: ["uid", "name", "profileImageURL"]))

                self.init(id: firebaseUser.uid, name: firebaseUser.displayName ?? parsedUser!.name, photo: parsedUser?.photo)

            case 1:
                let name = firebaseUser.providerData.first!.displayName!
                let imageUrl = firebaseUser.providerData.first!.photoURL

                self.init(id: firebaseUser.uid, name: name, photo: imageUrl)

            default:
                fatalError("hmmm... not 0 or 1 provider datas?")
            }
        }
    }
}

extension Firebase.User: Decodable {
    //swiftlint:disable:next variable_name
    static func decode(_ e: Extractor) throws -> Firebase.User {
        return try Firebase.User(
            id: e <| "uid",
            name: e <| "name",
            photo: try URLTransformer.apply(e <|? "profileImageURL")
        )
    }

    func encoded() -> [String: String] {
        var coded = [
            "uid": id,
            "name": name
        ]
        if let photoUrl = photo {
            coded["profileImageURL"] = photoUrl.absoluteString
        }

        return coded
    }
}

extension Firebase.Provider {

    func fetchUser(withId id: UserID) -> Observable<Firebase.User> {
        return ref
            .child("users")
            .child(id)
            .rx.observeEventOnce()
            .map { userData -> [String: AnyObject] in
                guard let json = userData.value as? [String : AnyObject] else {
                    fatalError()
                }
                return json
            }
            .map(Firebase.User.decodeValue)
    }

    func update(user newUser: Firebase.User) -> Observable<Firebase.User> {
        let firebaseUser = Firebase.User(id: newUser.id, name: newUser.name, photo: newUser.photo)

        return ref
            .child("users")
            .child(newUser.id)
            .rx.setValue(firebaseUser.encoded() as AnyObject)
            .mapTo(firebaseUser)
    }

}
