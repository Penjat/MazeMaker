import Foundation
import Combine

class PrimsMazeGenerator: ObservableObject {
    let VISITED = "visited"
    @Published var isProcessing = false
    var activeCells = [SquareCell]()
    let variation: Double = 0.6
    var cellCount = 0
    
    func findPaths(mazeProvider: SquareMaze) {
        guard !activeCells.isEmpty else {
            return
        }
//        let randomIndex = Double.random(in: 0...1) < variation ? Int.random(in: 0..<activeCells.count) : activeCells.count-1
        let randomIndex = cellCount < 500 ? Int.random(in: 0..<activeCells.count) : activeCells.count-1
        let cell = activeCells[randomIndex]
        let neighbors = mazeProvider.neighborsFor(cell.location).filter{ $0.data as? String ?? "" != VISITED}
        
        if neighbors.isEmpty {
            activeCells.remove(at: randomIndex)
        } else {
            if let otherCell = neighbors.randomElement(), let direction = cell.directionTo(otherCell) {
                mazeProvider.setWall(cell: cell.location, direction: direction, wallState: .open)
                otherCell.data = VISITED
                cellCount += 1
                activeCells.append(otherCell)
            }
        }
        findPaths(mazeProvider: mazeProvider)
    }
}
