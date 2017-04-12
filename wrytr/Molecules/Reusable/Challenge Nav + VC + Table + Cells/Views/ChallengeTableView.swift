import UIKit
import RxSwift
import RxCocoa
import Firebase
import Then

class ChallengeTableView: UITableView {
    fileprivate let disposeBag = DisposeBag()
    fileprivate var segmentedControlDisposeBag = DisposeBag()

    fileprivate static let sideInset: CGFloat = 14

    override var tintColor: UIColor! {
        didSet { topSegmentedControl.tintColor = tintColor }
    }

    let selectedSegmentControlSection = Variable(0) // start with section 0
    lazy var topSegmentedControl: SegmentedTableViewHeaderView = SegmentedTableViewHeaderView(frame: .zero).then {
        $0.frame.size.height = 50

        $0.tintColor = UIColor(named: .tint)
        $0.selected.bind(to: self.selectedSegmentControlSection).addDisposableTo(self.disposeBag)
    }

    var topSegmentedControlValue: ControlProperty<Int> {
        return topSegmentedControl.selected
    }

    var segmentedControlSectionTitles: [String] = [] {
        didSet {
            topSegmentedControl.segments = segmentedControlSectionTitles
        }
    }

    let posts = Variable([PostType]())
    lazy var postAtIndexPath: (IndexPath) -> PostType = { indexPath in self.posts.value[indexPath.section] }

    fileprivate var itemSelectedSubject = PublishSubject<PostType>()
    var itemSelected: Observable<PostType> { return itemSelectedSubject.asObservable() }

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

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        self.refreshControl = UIRefreshControl()

        // this initialValue is saved since accessing the topSegmentedControl binds to the selectedValue, which changes from initial (0) to the default value (-1)
        let initialValue = self.selectedSegmentControlSection.value
        topSegmentedControl.selectedSegmentIndex = initialValue

        self.rowHeight = UITableViewAutomaticDimension
        self.estimatedRowHeight = 100
        self.backgroundColor = .white

        (dataSource, delegate) = (self, self)

        posts.asObservable()
            .subscribe(onNext: { [weak self] _ in self?.reloadData() })
            .addDisposableTo(disposeBag)

        switch self.tableHeaderView {
        case .none:
            self.tableHeaderView = topSegmentedControl

        case .some(let header):
            header.frame.size.height += 50
            topSegmentedControl.frame.origin.y = header.frame.size.height - 50
            header.addSubview(topSegmentedControl)

        }
    }

}

extension ChallengeTableView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.itemSelectedSubject.onNext(postAtIndexPath(indexPath))
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension ChallengeTableView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.value.count
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case posts.value.count: return 0 // no extra spacing for the last section
        default:                return 11
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lol") as! ChallengeTableViewCell // swiftlint:disable:this force_cast
        let element = postAtIndexPath(indexPath)

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
