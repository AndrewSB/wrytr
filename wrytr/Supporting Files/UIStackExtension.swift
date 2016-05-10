//
//  UIStackExtension.swift
//  Lucid
//
//  Created by Andrew Breckenridge on 5/2/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import UIKit

extension UIStackView {
    
    func removeArrangedSubviews(except: (UIView -> Bool)? = nil) {
    
        arrangedSubviews.forEach { subview in
            if except?(subview) ?? true {
                removeArrangedSubview(subview)
                subview.removeFromSuperview()
            }
        }
    
    }
    
}

extension UIStackView {

    private class SpacerView: UIView {
        
        private override func contentHuggingPriorityForAxis(axis: UILayoutConstraintAxis) -> UILayoutPriority {
            return axis == .Horizontal ? 1 : super.contentHuggingPriorityForAxis(axis)
        }
        
    }
    
    func addEdgePadding() {
        addBeginningPadding()
        addEndingPadding()
    }
    
    func addBeginningPadding() {
        insertArrangedSubview(SpacerView(), atIndex: 0)
    }
    
    func addEndingPadding() {
        insertArrangedSubview(SpacerView(), atIndex: arrangedSubviews.count)
    }
    
    func removeEdgePadding() {
        
        arrangedSubviews
            .flatMap { $0 as? SpacerView }
            .forEach { spacer in
                removeArrangedSubview(spacer)
                spacer.removeFromSuperview()
            }
        
    }

}