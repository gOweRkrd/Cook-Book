import UIKit

extension Int {
    
    private var referenceSize: (width: CGFloat, height: CGFloat) { (390, 844) }
    private var screenSize: CGSize { UIScreen.main.bounds.size }
    
    var fitScreen: CGFloat {
        return CGFloat(screenSize.height / 3)
    }
    
    /// Сделать пропорционально ширине экрана iPhoneX, только если ширина текущего устройства больше ширины iPhoneX.
    var fitWMore: CGFloat {
        let ratio = screenSize.width / referenceSize.width
        return ratio > 1 ? CGFloat(self) * ratio : CGFloat(self)
    }
}
