import UIKit

protocol LoadingIndicatable: class {
    func startLoading()
    func stopLoading()
}

protocol ErrorPresentable: class {
    func presentError(error: PresentableError, actions: [UIAlertAction])
}

extension UIViewController: LoadingIndicatable {
    internal func startLoading() {
        self.startLoading(.gray)
    }
}

extension UIViewController: ErrorPresentable {
    func presentError(error: PresentableError, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: error.title, message: error.description, preferredStyle: .alert)
        actions.forEach(alert.addAction)

        self.present(alert, animated: true, completion: .none)
    }
}
