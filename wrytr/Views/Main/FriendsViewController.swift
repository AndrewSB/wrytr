import UIKit

import ReSwift
import ReSwiftRouter

import RxSwift
import RxCocoa

class FriendsViewController: RxViewController, Identifiable {
    
    static let identifier = "FriendsViewController"
    
    @IBOutlet weak var tableView: ChallengeTableView!
    @IBOutlet weak var postCategory: UISegmentedControl!
    
    let posts: Variable<[InflatedPost]>! = Variable([InflatedPost]())
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.title = "Friends"
        self.tabBarItem = UITabBarItem(title: self.title, image: UIImage(asset: .Icon_Tabbar_Friends), tag: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        posts.asObservable()
            .bindTo(tableView.data)
            .addDisposableTo(disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        store.dispatch(PostProvider.loadFriendPosts)
    }
}

extension FriendsViewController: StoreSubscriber {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        store.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        store.unsubscribe(self)
    }
    
    func newState(_ state: State) {
        
        posts.value = state.postState.new
    }
    
}

extension FriendsViewController: Routable {}
