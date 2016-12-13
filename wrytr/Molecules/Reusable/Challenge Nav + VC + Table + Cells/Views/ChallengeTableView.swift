import UIKit
import RxSwift
import RxCocoa
import Firebase

class ChallengeTableView: UITableView {
    fileprivate let disposeBag = DisposeBag()
    fileprivate var segmentedControlDisposeBag = DisposeBag()

    fileprivate static let sideInset: CGFloat = 14

    let selectedSegmentControlSection = Variable(0) // start with section 0
    var topSegmentedControlValue: ControlProperty<Int> {
        let segmentedHeader = self.tableView(self, viewForHeaderInSection: 0) as! SegmentedTableViewHeaderFooterView
        return segmentedHeader.selected
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
        self.backgroundColor = .white

        self.register(SegmentedTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "segmentedControl")

        (dataSource, delegate) = (self, self)

        posts.asObservable()
            .subscribe(onNext: { [weak self] _ in self?.reloadData() })
            .addDisposableTo(disposeBag)
    }

}

extension ChallengeTableView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) { // swiftlint:disable:this variable_name
//        view.tintColor = .clear // TODO: make sure this isn't needed
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let segmentHeader = self.dequeueReusableHeaderFooterView(withIdentifier: "segmentedControl") as! SegmentedTableViewHeaderFooterView
            segmentHeader.segments = self.segmentedControlSectionTitles
            segmentHeader.selectedSegmentIndex = self.selectedSegmentControlSection.value
            segmentHeader.tintColor = UIColor(named: .tint)

            segmentedControlDisposeBag = DisposeBag() // dispose of all the old ones before you grab the latest one
            segmentHeader.selected.bindTo(selectedSegmentControlSection).addDisposableTo(segmentedControlDisposeBag)

            return segmentHeader

        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 50
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
