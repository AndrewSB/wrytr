//
//  UIStackExtension.swift
//  Lucid
//
//  Created by Andrew Breckenridge on 5/2/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import UIKit

extension UIStackView {
    
    fileprivate class StackViewSpacer: UIView {}
    
}

extension UIStackView {
    
    func addEdgePadding(_ padding: CGFloat = 0 /* defaults to zero so you can use the stackView's padding */) {
        
        let spacers = (0..<2).map { _ in StackViewSpacer() }
        spacers.forEach { $0.backgroundColor = .yellow }
        
        if self.axis == .horizontal {
            spacers.forEach { view in view.widthAnchor.constraint(equalToConstant: padding) }
        } else {
            spacers.forEach { view in view.heightAnchor.constraint(equalToConstant: padding) }
        }
        
        insertArrangedSubview(spacers[0], at: 0)
        addArrangedSubview(spacers[1])
    }
    
    func removePadding() {
        
        arrangedSubviews
            .flatMap { subview in subview as? StackViewSpacer }
            .forEach { spacer in
                self.removeArrangedSubview(spacer)
                spacer.removeFromSuperview()
        }
        
    }
    
}
