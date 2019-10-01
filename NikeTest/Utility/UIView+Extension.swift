//
//  UIView+Extension.swift
//  Nike
//
//  Created by Varun on 01/10/19.
//  Copyright © 2019 Varun. All rights reserved.
//

import Foundation
import  UIKit

extension UIView {
    static func setConstraints(for element:AnyObject, toParent:AnyObject, leading:CGFloat = 0.0 ,trailing:CGFloat = 0.0, top:CGFloat = 0.0, bottom:CGFloat = 0.0, height:CGFloat = 0.0, width:CGFloat = 0.0, hasLeading:Bool = true, hasTrailing:Bool = true, hasTop:Bool = true, hasBottom:Bool = true, hasCenterX:Bool = false , hasCenterY:Bool = false, hasEqualHeight:Bool = false, hasEqualWidth:Bool = false) {
           
           if hasLeading {
               element.leadingAnchor.constraint(equalTo: toParent.leadingAnchor, constant: leading).isActive = true
           }
           if hasTrailing {
               element.trailingAnchor.constraint(equalTo:toParent.trailingAnchor, constant:trailing).isActive = true
           }
           if hasTop {
               element.topAnchor.constraint(equalTo:toParent.topAnchor, constant:top).isActive = true
           }
           if hasBottom {
               element.bottomAnchor.constraint(equalTo:toParent.bottomAnchor, constant:bottom).isActive = true
           }
           if height > 0.0 {
               element.heightAnchor.constraint(equalToConstant:height).isActive = true
           }
           if width > 0.0 {
               element.widthAnchor.constraint(equalToConstant:width).isActive = true
           }
           if hasCenterX {
               element.centerXAnchor.constraint(equalTo:toParent.centerXAnchor, constant:0.0).isActive = true
           }
           if hasCenterY {
               element.centerYAnchor.constraint(equalTo:toParent.centerYAnchor, constant:0.0).isActive = true
           }
           if hasEqualHeight {
               element.heightAnchor.constraint(equalTo:toParent.heightAnchor, constant:0.0).isActive = true
           }
           if hasEqualWidth {
               element.widthAnchor.constraint(equalTo:toParent.widthAnchor, constant:0.0).isActive = true
           }
       }
}
