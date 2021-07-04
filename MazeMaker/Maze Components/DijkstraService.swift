import Foundation

class DijkstraService {
    var longestPath = 0
    var futhestCells = [SquareCell]()
    var openCells = [SquareCell]()
    var deadEnds = [SquareCell]()
    func findFurthest(statingLocation: CellLocation = CellLocation(x: 0, y: 0), mazeProvider: SquareMaze) {
        guard let startingCell = mazeProvider.cellAt(statingLocation) else {
            return
        }
        openCells.append(startingCell)
        findDistances(value: 0, mazeProvider: mazeProvider)
        mazeProvider.clearData()
        openCells = [futhestCells.first].compactMap{$0}
        findDistances(value: 0, mazeProvider: mazeProvider, findDeadEnds: true)
    }
    func findDistances(value: Int, mazeProvider: SquareMaze, findDeadEnds: Bool = false) {
        var neighbors = [SquareCell]()
        for cell in openCells {
            neighbors = neighbors + mazeProvider.freeNeighbors(cell.location).filter{$0.data == nil}
            cell.data = value
            if findDeadEnds, mazeProvider.freeNeighbors(cell.location).count == 1 {
                print("dead end found")
                deadEnds.append(cell)
                cell.data = 0
            }
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
