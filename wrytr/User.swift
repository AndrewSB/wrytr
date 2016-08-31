import Foundation

import Firebase

struct User {
    let authData: User.AuthData
    
    let following: [String]?
}

extension User {
    
    struct AuthData {
        let name: String?
        let id: String
        let profilePictureUrl: String?
        
        init(dict: [String: String?]) {
            self.name = dict["name"]!
            self.id = dict["uid"]!!
            self.profilePictureUrl = dict["profilePictureUrl"]!
        }
        
        init(authData: FAuthData) {
            self.init(dict: AuthData.scrapeAuthData(authData))
        }
        
        static func scrapeAuthData(_ authData: FAuthData) -> [String: String?] {
            return [
                "uid": authData.uid,
                "name": authData.name,
                "profilePictureUrl": authData.profilePictureUrl.flatMap { "\($0)" } ?? "",
            ]
        }

    }

}

extension User {

    var profilePictureNSUrl: URL? {
        return authData.profilePictureUrl.flatMap(URL.init)
    }

}

extension User {
    
    static var local: User {
        return User(authData: User.AuthData(authData: firebase.authData), following: nil)
    }
    
}
