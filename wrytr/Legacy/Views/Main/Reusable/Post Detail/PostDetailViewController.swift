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

class PostDetailViewController: InterfaceProvidingViewController {
    let replyViewController = PostDetail.PublishReply.ViewController()
    let responsesViewController = PostDetail.Responses.ViewController()

    let imageView = UIImageView()
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!

    struct IB: Primitive {
        let title: UILabel
        let containerView: UIView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.contentMode = .scaleAspectFit

        view.backgroundColor = UIColor(named: .tint)
        self.navigationItem.titleView = imageView

        self.interface = IB(
            title: self.titleLabel!,
            containerView: containerView!
        )
    }

}
