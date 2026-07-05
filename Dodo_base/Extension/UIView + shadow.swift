import UIKit
import SnapKit

extension UIView {
    func applyShadow(cormerRadius: CGFloat){
        layer.cornerRadius = cormerRadius
        layer.masksToBounds = false
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
}

