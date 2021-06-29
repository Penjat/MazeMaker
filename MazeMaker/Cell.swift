import Foundation

enum WallState {
    case blocked
    case open
}
struct SquareCell {
    let x: Int
    let y: Int
    
    var topWall: WallState = .blocked
    var rightWall: WallState = .blocked
}
