//
//  KeyboardObserver.swift
//  Product
//
//  Created by muukii on 3/17/16.
//  Copyright © 2016 eure. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

public final class KeyboardObserver {
    
    public struct KeyboardInfo {
        
        public let animationDuration: Double
        public let animationCurve: UIViewAnimationOptions
        
        public let frameBegin: CGRect
        public let frameEnd: CGRect
        
        init(notification: Notification) {
            let userInfo = (notification as NSNotification).userInfo!
            
            self.animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
            
            let rawAnimationCurve = (userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).uint32Value << 16
            self.animationCurve = UIViewAnimationOptions(rawValue: UInt(rawAnimationCurve))
            
            self.frameBegin = (userInfo[UIKeyboardFrameBeginUserInfoKey]?.cgRectValue)!
            self.frameEnd = (userInfo[UIKeyboardFrameEndUserInfoKey]?.cgRectValue)!
        }
    }
    
    public let willChangeFrame = PublishSubject<KeyboardInfo>()
    public let didChangeFrame = PublishSubject<KeyboardInfo>()
    
    public let willShow = PublishSubject<KeyboardInfo>()
    public let didShow = PublishSubject<KeyboardInfo>()
    public let willHide = PublishSubject<KeyboardInfo>()
    public let didHide = PublishSubject<KeyboardInfo>()
    
    public init() {
        
        NotificationCenter.default
            .rx_notification(NSNotification.Name.UIKeyboardWillChangeFrame)
            .map { KeyboardInfo(notification: $0) }
            .bindTo(self.willChangeFrame)
            .addDisposableTo(self.disposeBag)
        
        NotificationCenter.default
            .rx_notification(NSNotification.Name.UIKeyboardDidChangeFrame)
            .map { KeyboardInfo(notification: $0) }
            .bindTo(self.didChangeFrame)
            .addDisposableTo(self.disposeBag)
        
        NotificationCenter.default
            .rx_notification(NSNotification.Name.UIKeyboardWillShow)
            .map { KeyboardInfo(notification: $0) }
            .bindTo(self.willShow)
            .addDisposableTo(self.disposeBag)
        
        NotificationCenter.default
            .rx_notification(NSNotification.Name.UIKeyboardDidShow)
            .map { KeyboardInfo(notification: $0) }
            .bindTo(self.didShow)
            .addDisposableTo(self.disposeBag)
        
        NotificationCenter.default
            .rx_notification(NSNotification.Name.UIKeyboardWillHide)
            .map { KeyboardInfo(notification: $0) }
            .bindTo(self.willHide)
            .addDisposableTo(self.disposeBag)
        
        NotificationCenter.default
            .rx_notification(NSNotification.Name.UIKeyboardDidHide)
            .map { KeyboardInfo(notification: $0) }
            .bindTo(self.didHide)
            .addDisposableTo(self.disposeBag)
    }
    
    fileprivate let disposeBag = DisposeBag()
}
