//
//  UIView + Extension.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/18/24.
//

import UIKit

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
    var identifier_: String {
        return String(describing: type(of: self))
    }
}
