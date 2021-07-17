import Foundation

struct MazeData {
    var walls: [Wall]
    var tiles: [Tile]
    
    static func +(lhs: MazeData, rhs: MazeData) -> MazeData {
        return MazeData(walls: lhs.walls + rhs.walls, tiles: lhs.tiles + rhs.tiles)
    }
}
