import UIKit
import RxSwift
import RxCocoa

protocol DismissesKeyboardOnTap: class {
    var disposeBag: DisposeBag { get }
    func registerForKeyboardDismissal()
}

extension DismissesKeyboardOnTap where Self: UIView {

    func defaultRegisterForKeyboardDismissal() {
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.rx.event.asDriver()
            .drive(onNext: { _ in self.endEditing(true) })
            .addDisposableTo(disposeBag)

        addGestureRecognizer(tapGestureRecognizer)
    }

}

class ViewThatDismissesKeyboardOnTap: UIView {
    let disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        registerForKeyboardDismissal()
    }
}

extension ViewThatDismissesKeyboardOnTap: DismissesKeyboardOnTap {
    func registerForKeyboardDismissal() {
        defaultRegisterForKeyboardDismissal()
    }
}
