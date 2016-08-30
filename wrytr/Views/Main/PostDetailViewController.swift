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
        
        imageView.contentMode = .scaleAspectFit
        
        view.backgroundColor = UIColor(named: .createBackground)
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
                    _ = inflatedPost.user.profilePictureNSUrl
                        .flatMap {
                            self.imageView.hnk_setImageFromURL($0)
                        }
                }
                self.titleLabel.text = inflatedPost.post.prompt
            }
            .addDisposableTo(disposeBag)
    }

}

extension PostDetailViewController: StoreSubscriber {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        store.subscribe(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        store.unsubscribe(self)
    }
    
    func newState(_ state: State) {
        self.displayState.value = state.feedState.displayState
        self.post.value = state.feedState.selectedPost
    }
    
}

extension PostDetailViewController {
    enum DisplayState {
        case list
        case reply
    }
}
