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

        return grid.flatMap{$0}.flatMap { cell -> [Wall] in
            guard let cell = cell else {
                return []
            }
            let cellSize = 20.0
            let xOffset = Double(cell.x)*cellSize
            let yOffset = Double(cell.y)*cellSize
            
            return [Wall(start: CGPoint(x: 0.0*cellSize+xOffset, y: 0.0*cellSize+yOffset), end: CGPoint(x: 1.0*cellSize+xOffset, y: 0.0*cellSize+yOffset)),
                    Wall(start: CGPoint(x: 0.0*cellSize+xOffset, y: 0.0*cellSize+yOffset), end: CGPoint(x: 0.0*cellSize+xOffset, y: 1.0*cellSize+yOffset)),
                    Wall(start: CGPoint(x: 1.0*cellSize+xOffset, y: 0.0*cellSize+yOffset), end: CGPoint(x: 1.0*cellSize+xOffset, y: 1.0*cellSize+yOffset)),
                    Wall(start: CGPoint(x: 1.0*cellSize+xOffset, y: 1.0*cellSize+yOffset), end: CGPoint(x: 0.0*cellSize+xOffset, y: 1.0*cellSize+yOffset))]
        }
    }
}
