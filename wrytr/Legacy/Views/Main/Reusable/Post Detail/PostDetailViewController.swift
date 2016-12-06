import UIKit
import PINRemoteImage
import RxSwift
import ReSwift

class PostDetail {
    typealias ViewController = PostDetailViewController
}

extension PostDetail.ViewController {
    static func fromStoryboard() -> PostDetail.ViewController {
        return StoryboardScene.PostDetail.instantiatePostDetail()
    }
}

class PostDetailViewController: UIViewController {
    let replyViewController = PostDetail.PublishReply.ViewController()
    let responsesViewController = PostDetail.Responses.ViewController()

    let imageView = UIImageView()
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.contentMode = .scaleAspectFit

        view.backgroundColor = UIColor(named: .tint)
        self.navigationItem.titleView = imageView
    }

}
