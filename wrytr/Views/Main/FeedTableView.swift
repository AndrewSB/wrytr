//
//  FeedTableView.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 4/28/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class FeedTableView: UITableView {
    
    let disposeBag = DisposeBag()
    
    let data = Variable([InflatedPost]())

    override func awakeFromNib() {
        super.awakeFromNib()
        
        (dataSource, delegate) = (self, self)
        
        data.asObservable()
            .subscribeNext { _ in self.reloadData() }
            .addDisposableTo(disposeBag)
        
        rx_itemSelected
            .subscribeNext { iPath in
                self.deselectRowAtIndexPath(iPath, animated: true)
//                store.dispatch(<#T##action: Action##Action#>)
            }
            .addDisposableTo(disposeBag)
    }
    
}

extension FeedTableView: UITableViewDelegate {
    
}

extension FeedTableView: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return data.value.count
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 10))
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("lol") as! FeedTableViewCell
        let element = data.value[indexPath.section]
        
        cell.prompt.text = (0...10).map { $0 }.map { _ in element.post.prompt }.joinWithSeparator(" ")
        cell.profilePicture.hnk_setImageFromURL(NSURL(string: element.user.profilePictureUrl)!)

        return cell
    }
    
}