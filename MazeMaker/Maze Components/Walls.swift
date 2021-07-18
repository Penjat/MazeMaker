import Foundation
#if os(iOS)
import UIKit
#endif

struct Wall {
    let start: CGPoint
    let end: CGPoint
    
    static func *(lhs: Wall, rhs: CGFloat) -> Wall {
        return Wall(start: lhs.start*rhs, end: lhs.end*rhs)
    }
}


