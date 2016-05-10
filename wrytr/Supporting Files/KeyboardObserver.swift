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
        
        init(notification: NSNotification) {
            let userInfo = notification.userInfo!
            
            self.animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
            
            let rawAnimationCurve = (userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).unsignedIntValue << 16
            self.animationCurve = UIViewAnimationOptions(rawValue: UInt(rawAnimationCurve))
            
            self.frameBegin = (userInfo[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue)!
            self.frameEnd = (userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue)!
        }
    }
    
    public let willChangeFrame = PublishSubject<KeyboardInfo>()
    public let didChangeFrame = PublishSubject<KeyboardInfo>()
    
    public let willShow = PublishSubject<KeyboardInfo>()
    public let didShow = PublishSubject<KeyboardInfo>()
    public let willHide = PublishSubject<KeyboardInfo>()
    public let didHide = PublishSubject<KeyboardInfo>()
    
    public init() {
        
        NSNotificationCenter.defaultCenter()
            .rx_notification(UIKeyboardWillChangeFrameNotification)
            .map { KeyboardInfo(notification: $0) }
            .bindTo(self.willChangeFrame)
            .addDisposableTo(self.disposeBag)
        
        NSNotificationCenter.defaultCenter()
            .rx_notification(UIKeyboardDidChangeFrameNotification)
            .map { KeyboardInfo(notification: $0) }
            .bindTo(self.didChangeFrame)
            .addDisposableTo(self.disposeBag)
        
        NSNotificationCenter.defaultCenter()
            .rx_notification(UIKeyboardWillShowNotification)
            .map { KeyboardInfo(notification: $0) }
            .bindTo(self.willShow)
            .addDisposableTo(self.disposeBag)
        
        NSNotificationCenter.defaultCenter()
            .rx_notification(UIKeyboardDidShowNotification)
            .map { KeyboardInfo(notification: $0) }
            .bindTo(self.didShow)
            .addDisposableTo(self.disposeBag)
        
        NSNotificationCenter.defaultCenter()
            .rx_notification(UIKeyboardWillHideNotification)
            .map { KeyboardInfo(notification: $0) }
            .bindTo(self.willHide)
            .addDisposableTo(self.disposeBag)
        
        NSNotificationCenter.defaultCenter()
            .rx_notification(UIKeyboardDidHideNotification)
            .map { KeyboardInfo(notification: $0) }
            .bindTo(self.didHide)
            .addDisposableTo(self.disposeBag)
    }
    
    private let disposeBag = DisposeBag()
}