import Foundation

class DijkstraService {
    var longestPath = 0
    var openCells = [SquareCell]()
    func findDistances(value: Int, mazeProvider: SquareMaze) {
        print("Starting serivice: \(value)  \(openCells.count) open cells")
        guard !openCells.isEmpty else {
            longestPath = value
            return
        }
        var neighbors = [SquareCell]()
        for cell in openCells {
            print("\(mazeProvider.freeNeighbors(cell.location).count)")
            neighbors = neighbors + mazeProvider.freeNeighbors(cell.location).filter{$0.data == nil}
            cell.data = value
        }
        print("neighbors: \(neighbors.count)")
        openCells = neighbors
        findDistances(value: value+1, mazeProvider: mazeProvider)
    }
}
