import UIKit
import SnapKit

extension UIView {
    var screenWidth: CGFloat {
        window?.windowScene?.screen.bounds.width ?? UIScreen.main.bounds.width
    }
}
