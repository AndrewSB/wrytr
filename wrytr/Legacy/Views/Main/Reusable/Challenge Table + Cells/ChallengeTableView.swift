import UIKit

import ReSwift
import ReSwiftRouter

import RxSwift
import RxCocoa

class ChallengeTableView: UITableView {
    
    let disposeBag = DisposeBag()
    
    let data = Variable([InflatedPost]())
    
    let sideInset: CGFloat = 14
    
}

extension ChallengeTableView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.rowHeight = UITableViewAutomaticDimension
        self.estimatedRowHeight = 100
        
        self.register(UINib(nibName: "ChallengeTableViewCell", bundle: nil), forCellReuseIdentifier: "lol")
        
        (dataSource, delegate) = (self, self)
        
        data.asObservable()
            .scan([InflatedPost]()) { (lastState, newValue) in
                if lastState != newValue {
                    self.reloadData()
                }
                return newValue
            }
            .subscribe()
            .addDisposableTo(disposeBag)

    }
        
}

extension ChallengeTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        store.dispatch(FeedProvider.selectPost(data.value[indexPath.section]))
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .clear
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 10
        }
    }
    
}

extension ChallengeTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lol") as! ChallengeTableViewCell
        let element = data.value[indexPath.section]
        
        cell.xInsets = sideInset
        cell.prompt.text = element.post.prompt
        
        _ = element.user.profilePictureNSUrl.flatMap {
            cell.profilePicture.pin_setImage(from: $0)
        }        

        return cell
    }
    
}
