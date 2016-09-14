import RxSwift

class Compose {

    func make(withCharacterCount characterCount: Int) -> (ViewController, Observable<String>) {
        let viewController = ViewController.fromStoryboard()
        let ui = UI(interface: viewController.interface as! ViewController.IB, characterLimit: characterCount)
        viewController.ui = ui

        return (viewController, ui.postCreated)
    }

}
