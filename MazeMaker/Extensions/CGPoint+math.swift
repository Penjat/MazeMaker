import Foundation
#if os(iOS)
import UIKit
#endif

extension CGPoint {
    static func * (left: CGPoint, right: CGFloat) -> CGPoint {
        return CGPoint(x: left.x * right, y: left.y * right)
    }
}

extension CGPoint {
    static func + (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
}

extension CGRect {
    static func * (left: CGRect, right: CGFloat) -> CGRect {
        return CGRect(x: left.minX*right, y: left.minY*right, width: left.width*right, height: left.height*right)
    }
}
