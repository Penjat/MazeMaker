import Foundation
import Combine

class PrimsMazeGenerator: ObservableObject {
    @Published var isProcessing = false
    var activeCells = [SquareCell]()
    
    func findPaths(mazeProvider: SquareMaze) {
        guard !activeCells.isEmpty else {
            return
        }
        let randomIndex = Int.random(in: 0..<activeCells.count)
        let cell = activeCells[randomIndex]
        let neighbors = mazeProvider.freeNeighbors(cell.location)
        
        if neighbors.isEmpty {
            activeCells.remove(at: randomIndex)
        } else {
            //selection process
            //connect to random neighbor
            if let otherCell = neighbors.randomElement(), let direction = cell.directionTo(otherCell) {
                mazeProvider.setWall(cell: cell.location, direction: direction, wallState: .open)
            }
        }
    }
}
