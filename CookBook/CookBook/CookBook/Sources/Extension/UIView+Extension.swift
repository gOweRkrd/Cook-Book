//
//  UIView+Extension.swift
//  CookBook
//
//  Created by Дария Григорьева on 10.12.2022.
//

import UIKit

extension UIView {
    
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
}
