import Foundation

enum WallState {
    case blocked
    case open
}

struct SquareCell {
    let x: Int
    let y: Int
    
    var topBlocked: WallState = .open
    var rightBlocked: WallState = .blocked
}

extension SquareCell {
    var topWall: Wall? {
        topBlocked == .open ? Wall(start: CGPoint(x: Double(x), y: Double(y)), end: CGPoint(x: 1.0 + Double(x), y: Double(y))) : nil
    }
    
    var rightmWall: Wall? {
        rightBlocked == .open ? Wall(start: CGPoint(x: 1.0 + Double(x), y: 0.0 + Double(y)), end: CGPoint(x: 1.0 + Double(x), y: 1.0)) : nil
    }
    
    var walls: [Wall] {
        return [topWall, rightmWall].compactMap{$0}
    }
}

extension CGPoint {
    static func * (left: CGPoint, right: CGFloat) -> CGPoint {
        return CGPoint(x: left.x * right, y: left.y * right)
    }
}
