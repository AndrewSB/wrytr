import UIKit
import Library
import RxSwift
import RxCocoa
import RxLibrary
import PINRemoteImage

class ProfilePhotoViewController: RxViewController {
    var user: Variable<UserType?> = Variable(nil)
    var state: Variable<State> = Variable(.none)

    @IBOutlet weak var avatarFillsWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var avatar: RoundedImageView! {
        didSet {
            avatar.clipsToBounds = true
            avatar.image = nil
        }
    }
    @IBOutlet private weak var accessory: RoundedButton! {
        didSet { accessory.imageView!.image = nil }
    }
    @IBOutlet private weak var accessoryUnderlay: RoundedView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.rx.observe(UIColor.self, "view.backgroundColor")
            .startWith(self.view.backgroundColor!)
            .subscribe(onNext: { color in self.accessoryUnderlay.backgroundColor = color })
            .addDisposableTo(disposeBag)

//        Observable<Int>.timer(1, period: 1, scheduler: MainScheduler.instance)
//            .scan(State.followed) { old, _ -> State in old == .followed ? .none : .followed }
//            .subscribe(onNext: self.bind)
//            .addDisposableTo(disposeBag)

        self.state.asDriver()
            .drive(onNext: self.bind)
            .addDisposableTo(disposeBag)

        self.user.asDriver()
            .map { $0?.photo }.ignoreNil()
            .drive(onNext: self.avatar.pin_setImage) // TODO: will this cause a self retain cycle?
            .addDisposableTo(disposeBag)
    }

    private func bind(state: State) {
        switch state {
        case .none:
            avatarFillsWidthConstraint.isActive = true
            accessoryUnderlay.isHidden = true
            accessory.isHidden = true

        case .follow:
            avatarFillsWidthConstraint.isActive = false
            accessoryUnderlay.isHidden = false
            accessory.isHidden = false
            accessory.imageView!.image = #imageLiteral(resourceName: "follow-button")

        case .followed:
            avatarFillsWidthConstraint.isActive = false
            accessoryUnderlay.isHidden = false
            accessory.isHidden = false
            accessory.imageView!.image = #imageLiteral(resourceName: "wrytr-worded")
        }
    }
}

extension ProfilePhotoViewController {
    enum State {
        case followed
        case follow
        case none
    }
}

extension ProfilePhotoViewController {
    static func fromStoryboard() -> ProfilePhotoViewController {
        return StoryboardScene.ProfilePhoto.instantiateProfilePhotoVC()
    }
}
