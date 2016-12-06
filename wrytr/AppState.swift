import Cordux
import RxCocoa

let appStore = Cordux.Store<App.State>(initialState: App.State(), reducer: appReducer, middlewares: [])

typealias StoreDependency = (
    state: ReadonlyStore<App.State>,
    dispatcher: Dispatcher<App.State>
)
let defaultStoreDependency: StoreDependency = (
    state: ReadonlyStore(store: appStore),
    dispatcher: Dispatcher(store: appStore)
)

class App {
    struct State: StateType {
        var route: Route = []

        var authenticationState = Authentication.State()
        var postState = Post.State()

        var landingState = Landing.State()
        var feedState = Feed.State()
        var createState = Create.State()
        var meState = Me.State()
    }
}

let appReducer = CombinedReducer([
    Authentication.Reducer(),
    Post.Reducer(),
    viewModelReducers
])

fileprivate let viewModelReducers = CombinedReducer([
    Landing.Reducer(),
    Feed.Reducer(),
    Create.Reducer(),
    Me.Reducer()
])
