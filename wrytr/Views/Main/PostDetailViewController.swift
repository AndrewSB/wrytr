import UIKit
import Haneke
import RxSwift
import ReSwift

class PostDetailViewController: RxViewController {
    
    static let identifier = "PostDetailViewController"
    
    let post = Variable<InflatedPost!>(nil)
    
    let replyViewController = PublishReplyViewController()
    let responsesViewController = PostResponsesViewController()
    let displayState = Variable<DisplayState!>(nil)
    
    let imageView = UIImageView()
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!

}

extension PostDetailViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.contentMode = .ScaleAspectFit
        
        view.backgroundColor = UIColor(named: .CreateBackground)
        self.navigationItem.titleView = imageView
        
        displayState.asObservable()
            .ignoreNil()
            .distinctUntilChanged(==)
            .subscribeNext { display in
                switch display! {
                case .List:
                    break
                case .Reply:
                    break
                }
            }
            .addDisposableTo(disposeBag)
        
        post.asObservable()
            .ignoreNil()
            .subscribeNext { inflatedPost in
                dispatch_async(dispatch_get_main_queue()) {
                    self.imageView.hnk_setImageFromURL(inflatedPost.user.profilePictureNSUrl)
                }
                self.titleLabel.text = inflatedPost.post.prompt
            }
            .addDisposableTo(disposeBag)
    }

}

extension PostDetailViewController: StoreSubscriber {

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        store.subscribe(self)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        store.unsubscribe(self)
    }
    
    func newState(state: State) {
        self.displayState.value = state.feedState.displayState
        self.post.value = state.feedState.selectedPost
    }
    
}

extension PostDetailViewController {
    enum DisplayState {
        case List
        case Reply
    }
}