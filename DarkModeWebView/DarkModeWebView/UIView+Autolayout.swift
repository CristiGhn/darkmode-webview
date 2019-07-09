//
//  UIView+Autolayout.swift
//  S4N
//
//  Created by Cristian Ghinea on 03/07/2019.
//  Copyright © 2019 Cristian Florin Ghinea. All rights reserved.
//

import UIKit

extension UIView {

    public func fillSuperview(left: CGFloat = 0, right: CGFloat = 0, top: CGFloat = 0, bottom: CGFloat = 0) {
        if let superview = self.superview {
            let leftConstraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: superview, attribute: .leading, multiplier: 1, constant: left)
            let rightConstraint = NSLayoutConstraint(item: superview, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: right)
            let topConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1, constant: top)
            let bottomConstraint = NSLayoutConstraint(item: superview, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: bottom)
            self.translatesAutoresizingMaskIntoConstraints = false
            superview.addConstraints([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
        }
    }
    
    public func pinToBottom() {
        if let superview = self.superview {
            let left = NSLayoutConstraint(item: superview, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
            let right = NSLayoutConstraint(item: superview, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
            let bottom = NSLayoutConstraint(item: superview, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
            self.translatesAutoresizingMaskIntoConstraints = false
            superview.addConstraints([left, right, bottom])
        }
    }
    
    public func pinToBottomSafeArea() {
        if #available(iOS 11.0, *) {
            guard let `superview` = superview else {
                return
            }
            
            self.translatesAutoresizingMaskIntoConstraints = false
            
            let guide = superview.safeAreaLayoutGuide
            self.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
            self.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        } else {
            // Fallback on earlier versions
            self.pinToBottom()
        }
    }
    
    public func centerInSuperview(x: CGFloat = 0, y: CGFloat = 0) {
        if let superview = self.superview {
            let centerX = NSLayoutConstraint(item: superview, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: x)
            let centerY = NSLayoutConstraint(item: superview, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: y)
            
            self.translatesAutoresizingMaskIntoConstraints = false
            superview.addConstraints([centerX, centerY])
        }
    }
}
