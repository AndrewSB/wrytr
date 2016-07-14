//
//  ChallengeTableView.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 4/28/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import UIKit

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
        
        self.registerNib(UINib(nibName: "ChallengeTableViewCell", bundle: nil), forCellReuseIdentifier: "lol")
        
        (dataSource, delegate) = (self, self)
        
        data.asObservable()
            .scan([InflatedPost]()) { (lastState, newValue) in
                if lastState != newValue {
                    self.reloadData()
                }
                return newValue
            }
            .subscribeNext { _ in }
            .addDisposableTo(disposeBag)

    }
        
}

extension ChallengeTableView: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .clearColor()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 10
        }
    }
    
}

extension ChallengeTableView: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return data.value.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("lol") as! ChallengeTableViewCell
        let element = data.value[indexPath.section]
        
        cell.xInsets = sideInset
        cell.prompt.text = element.post.prompt
        cell.profilePicture.hnk_setImageFromURL(NSURL(string: element.user.authData.profilePictureUrl)!)

        return cell
    }
    
}