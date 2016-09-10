import UIKit

extension Create {
    typealias ViewController = CreateViewController
}

extension Create.ViewController {
    static func fromStoryboard() -> CreateViewController {
        return StoryboardScene.Create.instantiateCreate()
    }
}

class CreateViewController: InterfaceProvidingViewController {

    struct IB: Primitive {}

}
