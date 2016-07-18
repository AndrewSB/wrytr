//
//  CreateViewController.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 4/14/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import UIKit

import RxSwift

import ReSwift
import ReSwiftRouter

import Haneke

class CreateViewController: RxViewController, Identifiable {
    
    static let identifier = "CreateViewController"
    
    @IBOutlet weak var profileImageView: UIImageView! {
        didSet { profileImageView.hnk_setImageFromURL(User.local.profilePictureNSUrl) }
    }
    @IBOutlet weak var usernameLabel: UILabel! {
        didSet { usernameLabel.text = User.local.authData.name }
    }
    @IBOutlet weak var challengeTextView: UITextView! {
        didSet { challengeTextView.delegate = self }
    }
    
    @IBOutlet weak var characterCountLabel: UILabel!
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.title = "Create"
        self.tabBarItem = UITabBarItem(title: self.title, image: UIImage(asset: .Icon_Tabbar_Create), tag: 2)
        
        self.navigationItem.title = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dismissKeyboardTap = UITapGestureRecognizer()
        dismissKeyboardTap.rx_event.subscribeNext { _ in self.view.endEditing(true) }.addDisposableTo(disposeBag)
        view.addGestureRecognizer(dismissKeyboardTap)
        
        let characterLimit = 150
        let attributedCharacterLimitString = attributedString("/\(characterLimit)", color: .blackColor())
        
        challengeTextView.rx_text
            .map { text in text.characters.count }
            .map { count in
                let countColor: UIColor = count >= characterLimit ? .redColor() : .grayColor()
                let countString = self.attributedString("\(count)", color: countColor)
                countString.appendAttributedString(attributedCharacterLimitString)
                return countString
            }
            .bindTo(characterCountLabel.rx_attributedText)
            .addDisposableTo(disposeBag)
        
        challengeTextView.rx_text
            .subscribeNext { _ in self.characterCountLabel.sizeToFit() }
            .addDisposableTo(disposeBag)
        
        KeyboardObserver().willShow
            .subscribeNext { _ in print("SEX")}
            .addDisposableTo(disposeBag)
    }

    private func attributedString(string: String, color: UIColor) -> NSMutableAttributedString {
        let attributedString = NSAttributedString(string: string, attributes: [NSForegroundColorAttributeName: color])
            
        return attributedString.mutableCopy() as! NSMutableAttributedString
    }
    
    private func animateKeyboardChange(keyboardInfo: KeyboardObserver.KeyboardInfo) {        

        let convertedKeyboardEndFrame = view.convertRect(keyboardInfo.frameEnd, fromView: view.window)
        
        bottomLayoutConstraint.constant = CGRectGetMaxY(self.view.bounds) - CGRectGetMinY(convertedKeyboardEndFrame)
        
        print("animating \(bottomLayoutConstraint.constant)")
        
        UIView.animateWithDuration(keyboardInfo.animationDuration, delay: 0.0, options: [.BeginFromCurrentState, keyboardInfo.animationCurve], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

extension CreateViewController: StoreSubscriber {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        store.subscribe(self)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        store.unsubscribe(self)
    }
    
    func newState(state: State) {
    
        if let result = state.createPostState.didUpload {
            switch result {
            case .Success(let post):
                print("post created \(post)")
            case .Failure(let error):
                print("error \(error)")
            }
        }
        
        if let _ = state.createPostState.toBeUploaded { stopLoading() }

    }
    
}

extension CreateViewController: Routable {}