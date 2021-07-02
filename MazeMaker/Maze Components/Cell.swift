import Foundation

enum WallState {
    case blocked
    case open
}

enum WallDirection {
    case top
    case right
    case bottom
    case left
}

class SquareCell {
    internal init(x: Int, y: Int, data: Any? = nil, topBlocked: WallState = .blocked, rightBlocked: WallState = .blocked) {
        self.x = x
        self.y = y
        self.data = data
        self.topBlocked = topBlocked
        self.rightBlocked = rightBlocked
    }
    
    let x: Int
    let y: Int
    var data: Any?
    
    public var topBlocked: WallState = .blocked
    public var rightBlocked: WallState = .blocked
}

extension SquareCell {
    var topWall: Wall? {
        topBlocked == .blocked ? Wall(start: CGPoint(x: Double(x), y: Double(y)), end: CGPoint(x: 1.0 + Double(x), y: Double(y))) : nil
    }
    
    var rightWall: Wall? {
        rightBlocked == .blocked ? Wall(start: CGPoint(x: 1.0 + Double(x), y: 0.0 + Double(y)), end: CGPoint(x: 1.0 + Double(x), y: 1.0 + Double(y))) : nil
    }
    
    var walls: [Wall] {
        return [topWall, rightWall].compactMap{$0}
    }
    
    var location: CellLocation {
        return CellLocation(x: x, y: y)
    }
    
    func directionTo(_ cell: SquareCell) -> WallDirection? {
        let xDistance = x-cell.x
        let yDistance = y-cell.y
        
        switch (xDistance, yDistance) {
        case (-1,0):
            return .right
        case (1,0):
            return .left
        case (0,-1):
            return .bottom
        case (0,1):
            return .top
        default:
            return nil
        }
    }
}

extension CGPoint {
    static func * (left: CGPoint, right: CGFloat) -> CGPoint {
        return CGPoint(x: left.x * right, y: left.y * right)
    }
}

extension CGRect {
    static func * (left: CGRect, right: CGFloat) -> CGRect {
        return CGRect(x: left.minX*right, y: left.minY*right, width: left.width*right, height: left.height*right)
    }
}
