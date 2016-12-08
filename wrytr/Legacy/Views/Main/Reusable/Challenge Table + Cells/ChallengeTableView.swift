import UIKit
import RxSwift
import RxCocoa

class ChallengeTableView: UITableView {
    fileprivate let disposeBag = DisposeBag()

    fileprivate static let sideInset: CGFloat = 14

    let posts = Variable([PostType]())

    private var _refreshControl: UIRefreshControl? // for pre-iOS 10
    override var refreshControl: UIRefreshControl? {
        get {
            if #available(iOS 10, *) {
                return super.refreshControl
            } else {
                return _refreshControl
            }
        }
        set {
            if #available(iOS 10, *) {
                super.refreshControl = newValue // TODO: not sure if this is right
            } else {
                _refreshControl?.removeFromSuperview()
                _refreshControl = newValue
                if let rc = newValue { self.addSubview(rc) }
            }
        }
    }
}

extension ChallengeTableView {

    override func awakeFromNib() {
        super.awakeFromNib()

        self.refreshControl = UIRefreshControl()

        self.rowHeight = UITableViewAutomaticDimension
        self.estimatedRowHeight = 100

        self.register(UINib(nibName: "ChallengeTableViewCell", bundle: nil), forCellReuseIdentifier: "lol")

        (dataSource, delegate) = (self, self)

        posts.asObservable().subscribe(onNext: { _ in self.reloadData() }).addDisposableTo(disposeBag)
    }

}

extension ChallengeTableView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) { // swiftlint:disable:this variable_name
        view.tintColor = .clear
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 10
        }
    }

}

extension ChallengeTableView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lol") as! ChallengeTableViewCell // swiftlint:disable:this force_cast
        let element = posts.value[indexPath.section]

        cell.xInsets = ChallengeTableView.sideInset
        cell.prompt.text = element.prompt

        User.Service.fetchUser(userID: element.author).map { $0.photo }
            .subscribe(onNext: { photoURL in
                cell.profilePicture.pin_setImage(from: photoURL)
            })
            .addDisposableTo(disposeBag)

        return cell
    }

}
