import Foundation

class DijkstraService {
    var longestPath = 0
    var futhestCells = [Cell]()
    var openCells = [Cell]()
    var deadEnds = [Cell]()
    var hallways = 0
    var threeWayJunctions = 0
    var fourWayJunction = 0
    func findFurthest(statingLocation: CellLocation = CellLocation(x: 0, y: 0), mazeProvider: SquareMaze) {
        guard let startingCell = mazeProvider.cellAt(statingLocation) else {
            return
        }
        openCells.append(startingCell)
        findDistances(value: 0, mazeProvider: mazeProvider)
        mazeProvider.clearData()
        openCells = [futhestCells.first].compactMap{$0}
        
        hallways = 0
        threeWayJunctions = 0
        fourWayJunction = 0
        
        findDistances(value: 0, mazeProvider: mazeProvider)
    }
    func findDistances(value: Int, mazeProvider: SquareMaze) {
        var neighbors = [Cell]()
        for cell in openCells {
            neighbors = neighbors + mazeProvider.freeNeighbors(cell.location).filter{$0.data == nil}
            cell.setData(value)
            let connectedNeighbors = mazeProvider.freeNeighbors(cell.location).count
            switch connectedNeighbors {
            case 1:
                deadEnds.append(cell)
            case 2:
                hallways += 1
            case 3:
                threeWayJunctions += 1
            case 4:
                fourWayJunction += 1
            default:
                fatalError("Should not be another value.")
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
