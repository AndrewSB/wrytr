import UIKit
import RxSwift
import RxCocoa
import Firebase

class ChallengeTableView: UITableView {
    fileprivate let disposeBag = DisposeBag()

    fileprivate static let sideInset: CGFloat = 14

    var topSegmentedControl: UISegmentedControl {
        let segmentedHeader = self.tableView(self, viewForHeaderInSection: 0) as! SegmentedTableViewHeaderFooterView
        return segmentedHeader.segmentedControl
    }

    var segmentedControlSectionTitles: [String] = []
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
        self.register(SegmentedTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "segmentedControl")

        (dataSource, delegate) = (self, self)

        posts.asObservable()
            .subscribe(onNext: { [weak self] _ in self?.reloadData() })
            .addDisposableTo(disposeBag)

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.posts.value.append(Firebase.Post(id: "", prompt: "idsbdabfiu", author: "facebook:10209194105510450", internalReactions: []))
        }
    }

}

extension ChallengeTableView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) { // swiftlint:disable:this variable_name
        view.tintColor = .clear
    }

    // TODO: I needed to implement this & headerView(forSection section: Int). That might be bad in the future?
    // If I didn't also implement `headerView(forSection section: Int)`, the app was crashing on launch because the header didn't exist when there were 0 rows
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header(forSection: section)
    }

//    override func headerView(forSection section: Int) -> UITableViewHeaderFooterView? {
//        return header(forSection: section)
//    }

    private func header(forSection section: Int) -> UITableViewHeaderFooterView? {
        switch section {
        case 0:
            let segmentHeader = self.dequeueReusableHeaderFooterView(withIdentifier: "segmentedControl") as! SegmentedTableViewHeaderFooterView
            segmentHeader.segmentedControl.removeAllSegments()
            self.segmentedControlSectionTitles.enumerated().forEach { idx, title in
                segmentHeader.segmentedControl.insertSegment(withTitle: title, at: idx, animated: false)
            }

            segmentHeader.backgroundColor = .red
            segmentHeader.segmentedControl.backgroundColor = .yellow
            return segmentHeader
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 44
        default:
            return 10
        }
    }

}

extension ChallengeTableView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch posts.value.count {
        case 0:
            return 0 // return 0 if there are no posts, to work with our hack in `numberOfSections`
        default:
            return 1
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        switch posts.value.count {
        case 0:
            return 1 // return 1 so we never have an empty tableView (so the segmented control header always shows)
        default:
            return posts.value.count
        }
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
