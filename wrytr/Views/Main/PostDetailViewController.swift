import UIKit
import RxSwift

class PostDetailViewController: RxViewController {
    
    static let identifier = "PostDetailViewController"
    
}

extension PostDetailViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: .CreateBackground)
    }

}