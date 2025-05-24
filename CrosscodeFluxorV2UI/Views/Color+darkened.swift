import SwiftUICore
import UIKit

extension Color {
    func darkened(by amount: Double) -> Color {
        return self.blend(with: .black, amount: amount)
    }

    func blend(with color: Color, amount: Double) -> Color {
        let uiSelf = UIColor(self)
        let uiBlend = UIColor(color)

        let blended = uiSelf.blend(with: uiBlend, amount: amount)
        return Color(uiColor: blended)
    }
}

extension UIColor {
    func blend(with color: UIColor, amount: Double) -> UIColor {
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
        
        self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)

        return UIColor(
            red: r1 * (1 - amount) + r2 * amount,
            green: g1 * (1 - amount) + g2 * amount,
            blue: b1 * (1 - amount) + b2 * amount,
            alpha: a1
        )
    }
}
