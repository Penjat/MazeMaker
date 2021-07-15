import Foundation

class RecursiveBacktraceGenertor {
    static let VISITED = "visited"
    static func generate(mazeProvider: MazeProvider) {
        print("generating maze")
        guard let location = mazeProvider.randomCell()?.location else {
            return
        }
        carvePaths(at: location, mazeProvider: mazeProvider)
        print("done")
    }
    
    static func carvePaths(at location: CellLocation, mazeProvider: MazeProvider) {
        mazeProvider.cellAt(location)?.setData(VISITED)
        for neighbor in mazeProvider.neighborsFor(location).shuffled() {
            if (neighbor.data as? String != VISITED), let cell = mazeProvider.cellAt(location) {
                mazeProvider.setWall(cell1: cell, cell2: neighbor, wallState: .open)
                carvePaths(at: neighbor.location, mazeProvider: mazeProvider)
            }
        }
    }
}
