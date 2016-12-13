import UIKit
import Library
import RxSwift
import RxCocoa
import RxLibrary
import PINRemoteImage

class ProfilePhoto: UIView {
    private let disposeBag = DisposeBag()

    override var backgroundColor: UIColor? {
        didSet {
            // match to the underlay
            accessoryUnderlay!.backgroundColor = backgroundColor
        }
    }

    var user: Variable<UserType?> = Variable(nil)
    var state: Variable<State> = Variable(.none)

    @IBOutlet private weak var avatar: RoundedImageView! {
        didSet { avatar.image = nil }
    }
    @IBOutlet private weak var accessory: RoundedButton! {
        didSet { accessory.imageView!.image = nil }
    }
    @IBOutlet private weak var accessoryUnderlay: RoundedView!

    override func awakeFromNib() {
        state.asDriver().drive(onNext: bind).addDisposableTo(disposeBag)

        user.asDriver()
            .map { $0?.photo }
            .ignoreNil()
            .drive(onNext: self.avatar.pin_setImage) // TODO: will this cause a self retain cycle?
            .addDisposableTo(disposeBag)
    }

    private func bind(state: State) {
        switch state {
        case .none:
            accessoryUnderlay.isHidden = true
            accessory.isHidden = true

        case .follow:
            accessoryUnderlay.isHidden = false
            accessory.isHidden = false
            accessory.imageView!.image = #imageLiteral(resourceName: "follow-button")

        case .followed:
            accessoryUnderlay.isHidden = false
            accessory.isHidden = false
            accessory.imageView!.image = #imageLiteral(resourceName: "wrytr-worded")
        }
    }
}

extension ProfilePhoto {
    enum State {
        case followed
        case follow
        case none
    }
}
