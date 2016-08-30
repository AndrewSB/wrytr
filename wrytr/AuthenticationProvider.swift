import Foundation

import Library

import Firebase

import RxSwift

import ReSwift
import ReSwiftRouter

import FBSDKLoginKit
import TwitterKit

// This is an example of an Action Creator Provider
class AuthenticationProvider {

    class func loginWithFacebook(_ state: StateType, store: Store<State>) -> Action? {
        
        FBSDKLoginManager().rx_login()
            .flatMap { loginResult -> Observable<FAuthData> in
                if loginResult.isCancelled {
                    return .error(NSError(localizedDescription: "Did you cancel the login?", code: 99))
                } else {
                    return firebase.rx_oauth("facebook", token: FBSDKAccessToken.currentAccessToken().tokenString)
                }
            }
            .map(Social.Facebook)
            .map(LoggedInState.LoggedIn)
            .flatMap(scrapeSocialData)
            .subscribe(handleAuthenticationResponse)
            .addDisposableTo(neverDisposeBag)
        
        return nil
    }
    
    class func loginWithTwitter(_ state: StateType, store: Store<State>) -> Action? {
        
        Twitter.sharedInstance().rx_login()
            .map { ("twitter", parameters: ["user_id": $0.userID, "oauth_token": $0.authToken, "oauth_token_secret": $0.authTokenSecret]) }
            .flatMap(firebase.rx_oauth)
            .map(Social.Twitter)
            .map(LoggedInState.LoggedIn)
            .flatMap(scrapeSocialData)
            .subscribe(handleAuthenticationResponse)
            .addDisposableTo(neverDisposeBag)
        
        return nil
    }
    
    fileprivate class func handleAuthenticationResponse(_ observer: Event<LoggedInState>) {
        
        switch observer {
        case .Error(let error):
            store.dispatch(UpdateLoggedInState(loggedInState: LoggedInState.ErrorLoggingIn(error as NSError)))
        case .Next(let loggedInState):
            store.dispatch(UpdateLoggedInState(loggedInState: loggedInState))
            store.dispatch(SetRouteAction([mainRoute]))
        case .Completed:
            break
        }
        
    }
    
    fileprivate class func scrapeSocialData(_ loggedInState: LoggedInState) -> Observable<LoggedInState> {
        let userRef = firebase?.child(byAppendingPath: "users/\(firebase?.authData.uid)")

        var userDict: [String: String] = [:]
        for (key, value) in User.AuthData.scrapeAuthData((firebase?.authData)!) {
            userDict[key] = value!
        }
        
        return (userRef?.rx_setValue(userDict as AnyObject!)
            .map { _ in loggedInState })!
    }
    
}

extension AuthenticationProvider {

    indirect enum Params {
        case signup(name: String, loginParams: Params)
        case login(email: String, password: String)
    }
    
    class func authWithFirebase(_ params: Params) -> ((_ state: StateType, _ store: Store<State>) -> Action?) {
        
        return { state, store in
            firebase?.rx_authUser(params)
                .map { LoggedInState.LoggedIn(.Firebase($0)) }
                .subscribe {
                    switch $0 {
                    case .Next(let loggedInState):
                        store.dispatch(UpdateLoggedInState(loggedInState: loggedInState))
                        store.dispatch(SetRouteAction([mainRoute]))
                    case .Error(let err):
                        store.dispatch(UpdateLoggedInState(loggedInState: LoggedInState.ErrorLoggingIn(err as NSError)))
                    case .Completed:
                        break
                    }
                }
            
            return nil
        }
    }

}

extension AuthenticationProvider {

    class func logout(_ state: StateType, store: Store<State>) -> Action? {
        
        firebase?.unauth()
        store.dispatch(SetRouteAction([loginRoute]))
        
        return UpdateLoggedInState(loggedInState: .Logout)
        
    }
}
