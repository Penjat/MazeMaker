import Foundation

class RecursiveBacktraceGenertor {
    static let VISITED = "visited"
    static func generate(mazeProvider: SquareMaze) {
        guard let location = mazeProvider.grid.randomElement()?.randomElement()??.location else {
            return
        }
        carvePaths(at: location, mazeProvider: mazeProvider)
    }
    
    static func carvePaths(at location: CellLocation, mazeProvider: SquareMaze) {
        mazeProvider.cellAt(location)?.data = VISITED
        for neighbor in mazeProvider.neighborsFor(location).shuffled() {
            if (neighbor.data as? String != VISITED), let cell = mazeProvider.cellAt(location), let direction = cell.directionTo(neighbor) {
                mazeProvider.setWall(cell: cell.location, direction: direction, wallState: .open)
                carvePaths(at: neighbor.location, mazeProvider: mazeProvider)
            }
        }
    }
}
