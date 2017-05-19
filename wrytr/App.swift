import Foundation

/**
 This is where globals are stored. I'd like it to be structured as something that explicitly defines all of the dependencies that can/will cause co-effects 
 */
class App {

    /// Application-level components, mostly services.
    struct Components {
        let api: (User.Service.Type, Post.Service.Type) // swiftlint:disable:this identifier_name
        let router: Router
        let thirdPartyServiceHandler: ThirdPartyServiceHandler
    }

    static var current: App!

    let store: DefaultStore
    let components: Components

    public init(store: DefaultStore, components: Components) {
        self.store = store
        self.components = components

        store.subscribe(components.router) { $0.route }
    }

    public func launch() {
        let initialRoute: AppRoute = {
            switch store.state.authenticationState.user {
            case .loggedIn:
                return .home(.feed(.table))
            case .loggedOut, .failedToLogin:
                return .auth(.landing)
            case .loggingIn:
                fatalError("logging in on launch? what??")
            }
        }

        store.dispatch(Routing(to: initialRoute))
    }

}
