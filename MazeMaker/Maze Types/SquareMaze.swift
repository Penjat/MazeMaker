import Foundation

protocol MazeProvider {
    
}

class SquareMaze: MazeProvider, ObservableObject {
    @Published var grid = [[SquareCell?]]()
    init(width: Int, height: Int) {
        grid = [[SquareCell?]](repeating: [SquareCell?](repeating: nil, count: height), count: width)
        blankMaze(width: width, height: height)
        generateMaze()
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
    
    func blankMaze(width: Int, height: Int){
        for x in 0..<width {
            for y in 0..<height {
                grid[x][y] = SquareCell(x: x, y: y)
            }
        }
    }
    
    func generateMaze() {
        blankMaze(width: grid.count, height: grid[0].count)
        grid = BinaryTreeMazeGenerator.generateMaze(grid)
    }
}

struct CellLocation {
    let x: Int
    let y: Int
}
