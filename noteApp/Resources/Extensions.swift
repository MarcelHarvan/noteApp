//
//  Extensions.swift
//  noteApp
//
//  Created by Marcel Harvan on 2018-10-29.
//  Copyright © 2018 Marcel Harvan. All rights reserved.
//

import UIKit
// view extension
extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?,
                left: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                right: NSLayoutXAxisAnchor?,
                paddingTop: CGFloat,
                paddingLeft: CGFloat,
                paddingBottom: CGFloat,
                paddingRight: CGFloat,
                width: CGFloat,
                height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
// color extension
extension UIColor {
    static var yellowNavBar = UIColor(red: 255/255, green: 255/255, blue: 153/255, alpha: 1)
    static var grayText = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
    static var yellowBody = UIColor(red: 255/255, green: 255/255, blue: 204/255, alpha: 1)
}
