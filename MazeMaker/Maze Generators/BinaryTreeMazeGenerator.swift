import Foundation

class BinaryTreeMazeGenerator {
    static func generateMaze(_ grid: [[SquareCell?]]) -> [[SquareCell?]] {
        var outputGrid = grid
        for x in 0..<outputGrid.count {
            for y in 0..<outputGrid[x].count {
                let topLimit = (y == 0)
                let rightLimit = (x+1 == outputGrid.count)
                switch (topLimit, rightLimit) {
                case (false, false):
                    Bool.random() ? (outputGrid[x][y]?.topBlocked = .open) : (outputGrid[x][y]?.rightBlocked = .open)
                case (true, false):
                    outputGrid[x][y]?.rightBlocked = .open
                case (false, true):
                    outputGrid[x][y]?.topBlocked = .open
                case (true, true):
                    break
                }
            }
        }
        return outputGrid
    }
}
