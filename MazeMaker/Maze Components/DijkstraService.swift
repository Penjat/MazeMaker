import Foundation

class DijkstraService {
    var longestPath = 0
    var futhestCells = [SquareCell]()
    var openCells = [SquareCell]()
    func findFurthest(statingLocation: CellLocation = CellLocation(x: 0, y: 0), mazeProvider: SquareMaze) {
        guard let startingCell = mazeProvider.cellAt(statingLocation) else {
            return
        }
        openCells.append(startingCell)
        findDistances(value: 0, mazeProvider: mazeProvider)
        mazeProvider.clearData()
        openCells = [futhestCells.first].compactMap{$0}
        findDistances(value: 0, mazeProvider: mazeProvider)
    }
    func findDistances(value: Int, mazeProvider: SquareMaze) {
        var neighbors = [SquareCell]()
        for cell in openCells {
            neighbors = neighbors + mazeProvider.freeNeighbors(cell.location).filter{$0.data == nil}
            cell.data = value
        }
        guard !neighbors.isEmpty else {
            longestPath = value
            futhestCells = openCells
            openCells = []
            return
        }
        openCells = neighbors
        findDistances(value: value+1, mazeProvider: mazeProvider)
    }
}
