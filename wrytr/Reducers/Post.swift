import Foundation

import RxSwift

import Firebase

struct Post {
    let id: String?

    let userId: String
    let prompt: String

    let stars: [Response]?
    let comments: [Response]?
    
}

extension Post {
    
    func inflate() -> Observable<InflatedPost> {
        
        return firebase.child(byAppendingPath: "users/\(userId)").rx_observeEventOnce(.value)
            .map {
                var dict = $0.value as! [String: String]
                dict["uid"] = $0.key
                
                var optionalValueDict = [String: String?]()
                dict.forEach { key, val in
                    optionalValueDict[key] = val
                }
                
                return optionalValueDict
            }
            .map { User.AuthData(dict: $0) }
            .map { ($0, nil) }
            .map(User.init)
            .map { user in
                InflatedPost(post: self, user: user)
            }
    }
    
    static func inflate(_ posts: [Post]) -> Observable<[InflatedPost]> {
        return Observable.from(posts.map { $0.inflate() })
            .merge()
            .toArray()
    }
    
}

extension Post {
    
    static func parseFromFirebase(_ snapshot: FDataSnapshot) -> [Post] {
        let snapshotKeys = snapshot.value as? Dictionary<String, Dictionary<String, String>>
        
        let posts: [Post] = snapshotKeys?.map { postDict -> Post in
            Post(
                id: postDict.0,
                userId: postDict.1["userId"]!,
                prompt: postDict.1["prompt"]!,
                stars: nil,
                comments: nil
            )
            } ?? [Post]()
        
        return posts
    }
    
}

extension Post {

    func asAnyObject() -> AnyObject {
        
        return [
            "userId": userId,
            "prompt": prompt
        ] as AnyObject
        
    }
    
    

}
