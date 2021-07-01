import Foundation

protocol MazeProvider {
    
}

class SquareMaze: MazeProvider {
    var grid = [[SquareCell?]]()
    init(width: Int, height: Int) {
        grid = [[SquareCell?]](repeating: [SquareCell?](repeating: nil, count: height), count: width)
        for x in 0..<width {
            for y in 0..<height {
                grid[x][y] = SquareCell(x: x, y: y)
            }
        }
        grid[10][10]?.rightBlocked = .open
        grid[12][10]?.rightBlocked = .open
        grid[2][13]?.topBlocked = .open
        
    }
    
    var leftWall: Wall {
        Wall(start: CGPoint.zero, end: CGPoint(x: 0.0, y: CGFloat(grid[0].count)))
    }
    
    var bottomWall: Wall {
        Wall(start: CGPoint(x: 0.0, y: CGFloat(grid[0].count)), end: CGPoint(x: CGFloat(grid.count), y: CGFloat(grid[0].count)))
    }
    
    func walls() -> [Wall] {
        return grid.flatMap{$0}.flatMap { cell -> [Wall] in
            cell?.walls ?? []
        } + [leftWall, bottomWall]
    }
}

struct CellLocation {
    let x: Int
    let y: Int
}
