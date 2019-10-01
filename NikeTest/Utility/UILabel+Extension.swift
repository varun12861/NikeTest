//
//  UILabel+Extension.swift
//  Nike
//
//  Created by Varun on 01/10/19.
//  Copyright © 2019 Varun. All rights reserved.
//

import Foundation
import  UIKit
extension UILabel {
    static func createLabel(with text:String = "" ) -> UILabel {
        let label = UILabel()
        label.text = text
        return label
    }
}
