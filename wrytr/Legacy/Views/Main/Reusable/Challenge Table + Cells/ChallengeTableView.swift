import UIKit
import RxSwift
import RxCocoa

class ChallengeTableView: UITableView {
    fileprivate let disposeBag = DisposeBag()

    fileprivate let sideInset: CGFloat = 14

    let posts = Variable([PostType]())
}

extension ChallengeTableView {

    override func awakeFromNib() {
        super.awakeFromNib()

        self.rowHeight = UITableViewAutomaticDimension
        self.estimatedRowHeight = 100

        self.register(UINib(nibName: "ChallengeTableViewCell", bundle: nil), forCellReuseIdentifier: "lol")

        (dataSource, delegate) = (self, self)
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

        cell.xInsets = sideInset
        cell.prompt.text = element.prompt

        User.Service.fetchUser(userID: element.author).map { $0.photo }
            .subscribe(onNext: { photoURL in
                cell.profilePicture.pin_setImage(from: photoURL)
            })
            .addDisposableTo(disposeBag)

        return cell
    }

}
