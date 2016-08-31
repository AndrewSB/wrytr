import UIKit
import PINRemoteImage
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
        
        view.backgroundColor = UIColor(named: .CreateBackground)
        self.navigationItem.titleView = imageView
        
        displayState.asObservable()
            .ignoreNil()
            .distinctUntilChanged(==)
            .subscribe(onNext: { display in
                switch display! {
                case .list:
                    break
                case .reply:
                    break
                }
            })
            .addDisposableTo(disposeBag)
        
        post.asObservable()
            .ignoreNil()
            .subscribe(onNext: { inflatedPost in
                DispatchQueue.main.async {
                    _ = inflatedPost.user.profilePictureNSUrl.flatMap {
                        self.imageView.pin_setImage(from: $0)
                    }
                    self.titleLabel.text = inflatedPost.post.prompt
                }
            })
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
    
    func newState(state: State) {
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
