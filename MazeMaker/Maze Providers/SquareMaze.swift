import Foundation
import SwiftUI

protocol MazeProvider {
    
}

class SquareMaze: MazeProvider, ObservableObject {
    @Published var longestDepth = 0
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
    
    func freeNeighbors(_ cellLocation: CellLocation) -> [SquareCell] {
        guard let cell = cellAt(cellLocation) else {
            return []
        }
        var neighbors = [SquareCell]()
        if cell.topBlocked == .open, let topCell = cellAt(x: cell.x, y: cell.y-1) {
            neighbors.append(topCell)
        }
        if cell.rightBlocked == .open, let rightCell = cellAt(x: cell.x+1, y: cell.y) {
            neighbors.append(rightCell)
        }
        if let leftCell = cellAt(x: cell.x-1, y: cell.y), leftCell.rightBlocked == .open {
            neighbors.append(leftCell)
        }
        if let bottomCell = cellAt(x: cell.x, y: cell.y+1), bottomCell.topBlocked == .open {
            neighbors.append(bottomCell)
        }
        return neighbors
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
    
    func tiles() -> [(CGRect,Double)] {
        return grid.flatMap{$0}.flatMap { cell -> (CGRect, Double) in
            let value = Double(cell?.data as? Int ?? 1)/Double(longestDepth)
            return (CGRect(x: cell!.x, y: cell!.y, width: 1, height: 1), value)
        }
    }
    
    func blankMaze(width: Int, height: Int){
        for x in 0..<width {
            for y in 0..<height {
                grid[x][y] = SquareCell(x: x, y: y)
            }
        }
    }
    
    func allCells() -> [SquareCell] {
        return grid.flatMap{$0}.flatMap {$0}
    }
    
    func clearData() {
        for cell in allCells(){
            cell.data = nil
        }
    }
    
    func generateMaze() {
        blankMaze(width: grid.count, height: grid[0].count)
        RecursiveBacktraceGenertor.generate(mazeProvider: self)
        clearData()
        let ds = DijkstraService()
        ds.openCells.append(grid[0][0]!)
        ds.findFurthest(mazeProvider: self)
        longestDepth = ds.longestPath
    }
    
    func generateBinaryMaze() {
        blankMaze(width: grid.count, height: grid[0].count)
        grid = BinaryTreeMazeGenerator.generateMaze(grid)
        clearData()
        let ds = DijkstraService()
        ds.openCells.append(grid[0][0]!)
        ds.findFurthest(mazeProvider: self)
        longestDepth = ds.longestPath
    }
    
    func generateSimplifiedPrimsMaze() {
        blankMaze(width: grid.count, height: grid[0].count)
        
    }
}

struct CellLocation {
    let x: Int
    let y: Int
}

struct ColorInput {
    let red: Double
    let blue: Double
    let green: Double
}
