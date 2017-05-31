import Foundation
import ReSwift
import RxSwift
import RxCocoa
import UIKit.UIApplication

/**
 This is where globals are stored. I'd like it to be structured as something that explicitly defines all of the dependencies that can/will cause co-effects 
 */
class App {
    static var current: App!

    let store: DefaultStore
    let components: Components

    private let disposeBag = DisposeBag()

    private let appActivated = PublishSubject<Void>()
    lazy var onAppActivate: (() -> Void) = self.appActivated.onNext

    private let appOpenedUrl = PublishSubject<AppURLOpenParams>()
    private let appShouldOpenUrl: Variable<Bool> = Variable(false)
    lazy var onAppOpenUrl: (AppURLOpenParams) -> Bool = {
        self.appOpenedUrl.onNext($0) // This
        return self.appShouldOpenUrl.value
    }

    private lazy var bindings: [Disposable] = [
        self.appActivated.asDriver(onErrorJustReturn: ()) // waiting to replae this with a relay
            .do(onNext: self.components.facebook.1.activateApp)
            .drive(),
        Observable.zip(
            self.appOpenedUrl.map { self.components.facebook.0.application($0, open: $1, options: $2) },
            self.appOpenedUrl.map { self.components.twitter.application($0, open: $1, options: $2) }
            ) { $0 || $1 }
            .asDriver(onErrorRecover: { _ in fatalError() }) // waiting to replace this with a relay
            .drive(self.appShouldOpenUrl)
    ]

    public init(store: DefaultStore, components: Components) {
        self.store = store
        self.components = components

        self.bindings.forEach(disposeBag.insert)

        store.subscribe(components.router) { $0.select({ $0.route }) }
    }
}
