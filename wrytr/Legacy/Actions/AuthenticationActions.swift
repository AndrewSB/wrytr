import Foundation

import ReSwift

struct UpdateLoggedInState: Action {
    let loggedInState: LoggedInState
}

struct NewLandingState: Action {
    let state: LandingFormViewController.State
}
