//
//  Int+Scaling.swift
//  Quotex
//

import UIKit

extension Int {
    private var referenceSize: (width: CGFloat, height: CGFloat) { (390, 844) }
    private var screenSize: CGSize { UIScreen.main.bounds.size }
    
    var fitScreen: CGFloat {
        return CGFloat(screenSize.height / 3)
    }
    
    var fitImageMainn: CGFloat {
        return CGFloat(screenSize.height / 0.8)
    }
    
    var fit: CGFloat {
        var ratio: CGFloat = 1
        if screenSize.height > referenceSize.height {
            ratio = screenSize.height / referenceSize.height
        }
        return CGFloat(self) * ratio
    }
    
    var fitY: CGFloat {
        var ratio: CGFloat = 1
        if screenSize.height >= referenceSize.height {
            ratio = screenSize.height / referenceSize.height
        } else {
            ratio = screenSize.height / referenceSize.height / 1.15
        }
        return CGFloat(self) * ratio
    }
    
    /// Подогнать под ширину экрана iPhoneX.
    var fitW: CGFloat {
        let ratio = screenSize.width / referenceSize.width
        return CGFloat(self) * ratio
    }
    
    /// Подогнать под высоту экрана iPhoneX.
    var fitH: CGFloat {
        let ratio = screenSize.height / referenceSize.height
        return CGFloat(self) * ratio
    }
    
    /// Сделать пропорционально ширине экрана iPhoneX, только если ширина текущего устройства больше ширины iPhoneX.
    var fitWMore: CGFloat {
        let ratio = screenSize.width / referenceSize.width
        return ratio > 1 ? CGFloat(self) * ratio : CGFloat(self)
    }
}
