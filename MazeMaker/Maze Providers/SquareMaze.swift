import Foundation
import SwiftUI

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
    
    func neighborsFor(_ cellLocation: CellLocation) -> [SquareCell] {
        return neighborsFor(x: cellLocation.x, y: cellLocation.y)
    }
    
    func neighborsFor(x: Int, y: Int) -> [SquareCell] {
        return [cellAt(x: x, y: y+1), cellAt(x: x+1, y: y), cellAt(x: x-1, y: y), cellAt(x: x, y: y-1)].compactMap{$0}
    }
    
    func setWall(cell: CellLocation, direction: WallDirection, wallState: WallState) {
        switch direction {
        case .top:
            cellAt(cell)?.topBlocked = wallState
        case .right:
            cellAt(cell)?.rightBlocked = wallState
        case .left:
            cellAt(x: cell.x-1, y: cell.y)?.rightBlocked = wallState
        case .bottom:
            cellAt(x: cell.x, y: cell.y+1)?.topBlocked = wallState
        }
    }
    
    func cellAt(_ cellLocation: CellLocation) -> SquareCell? {
        return cellAt(x: cellLocation.x, y: cellLocation.y)
    }
    
    func cellAt(x: Int, y: Int) -> SquareCell? {
        guard x < grid.count, y < grid[0].count, x >= 0, y >= 0 else {
            return nil
        }
        return grid[x][y]
    }
    
    func walls() -> [Wall] {
        return grid.flatMap{$0}.flatMap { cell -> [Wall] in
            cell?.walls ?? []
        } + [leftWall, bottomWall]
    }
    
    func tiles() -> [(CGRect,Color)] {
        return grid.flatMap{$0}.flatMap { cell -> (CGRect, Color) in
            return (CGRect(x: cell!.x ?? 0, y: cell!.y ?? 0, width: 1, height: 1),Color.red)
            
        }
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
        RecursiveBacktraceGenertor.generate(mazeProvider: self)
    }
    
    func generateBinaryMaze() {
        blankMaze(width: grid.count, height: grid[0].count)
        grid = BinaryTreeMazeGenerator.generateMaze(grid)
    }
}

struct CellLocation {
    let x: Int
    let y: Int
}
