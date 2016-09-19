import UIKit
import PINRemoteImage
import RxSwift
import ReSwift

extension PostDetail {
    typealias ViewController = PostDetailViewController
}

extension PostDetail.ViewController {
    static func fromStoryboard() -> PostDetail.ViewController {
        return StoryboardScene.PostDetail.instantiatePostDetail()
    }
}

class PostDetailViewController: RxViewController {

    let replyViewController = PublishReplyViewController()
    let responsesViewController = PostResponsesViewController()

    let imageView = UIImageView()
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!

    struct IB {
        let title: UILabel
        let containerView: UIView
    }

}

extension PostDetailViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.contentMode = .scaleAspectFit

        view.backgroundColor = UIColor(named: .CreateBackground)
        self.navigationItem.titleView = imageView
    }

}
