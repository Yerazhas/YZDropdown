//
//  Extensions.swift
//  YZDropdown
//
//  Created by Yerassyl Zhassuzakhov on 6/16/19.
//  Copyright © 2019 Yerassyl Zhassuzakhov. All rights reserved.
//

import UIKit

extension UIView {
    func addShadow(with color: UIColor = .lightGray, radius: CGFloat) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 0.8
        layer.cornerRadius = radius
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 2
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: radius).cgPath
    }
    
    func removeShadow() {
        layer.shadowPath = nil
        layer.cornerRadius = 0
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0
    }
}
