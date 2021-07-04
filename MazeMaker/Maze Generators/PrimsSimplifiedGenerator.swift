import Foundation
import Combine

class PrimsMazeGenerator: ObservableObject {
    let VISITED = "visited"
    @Published var isProcessing = false
    var activeCells = [SquareCell]()
    
    func findPaths(mazeProvider: SquareMaze) {
        guard !activeCells.isEmpty else {
            return
        }
        let randomIndex = Int.random(in: 0..<activeCells.count)
        let cell = activeCells[randomIndex]
        let neighbors = mazeProvider.neighborsFor(cell.location).filter{ $0.data as? String ?? "" != VISITED}
        
        if neighbors.isEmpty {
            activeCells.remove(at: randomIndex)
        } else {
            if let otherCell = neighbors.randomElement(), let direction = cell.directionTo(otherCell) {
                mazeProvider.setWall(cell: cell.location, direction: direction, wallState: .open)
                otherCell.data = VISITED
                activeCells.append(otherCell)
            }
        }
        findPaths(mazeProvider: mazeProvider)
    }
}
