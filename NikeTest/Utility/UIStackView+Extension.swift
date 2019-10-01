//
//  UIStackView+Extension.swift
//  Nike
//
//  Created by Varun on 01/10/19.
//  Copyright © 2019 Varun. All rights reserved.
//

import Foundation
import  UIKit

extension UIStackView {
    static func createStackView(elements:[UIView], axis:NSLayoutConstraint.Axis, alignment:UIStackView.Alignment, distribution:UIStackView.Distribution,spacing:CGFloat)-> UIStackView {
        let stackView = UIStackView(arrangedSubviews:elements)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = alignment
        stackView.distribution = distribution
        return stackView
    }
}
