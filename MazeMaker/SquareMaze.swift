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
    }
    
    func walls() -> [Wall] {

        return grid.flatMap{$0}.flatMap { cell in
            guard let cell = cell else {
                return nil
            }
            return Wall(start: CGPoint(x: 0.0*Double(cell.x), y: 10.0*Double(cell.y)), end: CGPoint(x: 20.0*Double(cell.x), y: 10.0*Double(cell.y)))
        }
    }
}
