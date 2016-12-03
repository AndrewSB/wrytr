import UIKit
import Library
import RxSwift
import RxCocoa
import Cordux

extension Landing {

    class UI: UIType {
        weak var loaderAndErrorPresenter: (ErrorPresentable & LoadingIndicatable)?

        let interface: ViewController.IB
        let handler: Handler


        init(interface: ViewController.IB, handler: Handler) {
            self.interface = {


                return $0
            }(interface)

            self.handler = handler
        }
    }

}

extension Landing.UI: Renderer {
    func render(_ viewModel: Landing.ViewModel) {
        renderAuthOption(option: viewModel.option)

        _ = viewModel.loading ? showLoading() : hideLoading()
        viewModel.error.flatMap { err in
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: self.handler.errorOkTap)
            self.presentError(error: err, actions: [okAction])
        }
    }

    fileprivate func renderAuthOption(option: Landing.ViewModel.Option) {
        let wordedOption: String
        let oppositeWordedOption: String
        let helperTitle: String
        switch option {
        case .login:
            wordedOption = tr(.loginLandingLoginTitle)
            oppositeWordedOption = tr(.loginLandingRegisterTitle)
            helperTitle = tr(.loginLandingHelperLoginTitle)
        case .register:
            wordedOption = tr(.loginLandingRegisterTitle)
            oppositeWordedOption = tr(.loginLandingLoginTitle)
            helperTitle = tr(.loginLandingHelperRegisterTitle)
        }

        self.interface.formContainer.layoutIfNeeded()

        self.interface.formHeader.text = tr(L10n.loginLandingEmailbuttonTitle(wordedOption))
        self.interface.usernameField.isHidden = option == .login
        self.interface.actionButton.set(title: wordedOption)
        self.interface.helperButton.set(title: oppositeWordedOption)
        self.interface.helperLabel.text = helperTitle

        UIView.animate(withDuration: 0.2) {
            self.interface.formContainer.layoutIfNeeded()
        }
    }
}
