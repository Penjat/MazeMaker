import Foundation
import Combine

class PrimsMazeGenerator: ObservableObject {
    let VISITED = "visited"
    @Published var isProcessing = false
    var activeCells = [Cell]()
    let variation: Double = 0.6
    var cellCount = 0
    var tunnelLength = Int.random(in: 1...150)
    
    func findPathsCycling(mazeProvider: MazeProvider) {
        guard !activeCells.isEmpty else {
            return
        }
//        let randomIndex = Double.random(in: 0...1) < variation ? Int.random(in: 0..<activeCells.count) : activeCells.count-1
//        let randomIndex = cellCount < 500 ? Int.random(in: 0..<activeCells.count) : activeCells.count-1
        let randomIndex = 0
        let cell = activeCells[randomIndex]
        let neighbors = mazeProvider.neighborsFor(cell.location).filter{ $0.data as? String ?? "" != VISITED}
        
        if neighbors.isEmpty {
            activeCells.remove(at: randomIndex)
        } else {
            if let otherCell = neighbors.randomElement() {
                mazeProvider.setWall(cell1: cell, cell2: otherCell, wallState: .open)
                otherCell.setData(VISITED)
                cellCount += 1
                
                activeCells.remove(at: 0)
                activeCells.append(cell)
                activeCells.append(otherCell)
            }
//            if cellCount%tunnelLength == 0 {
//                activeCells.shuffle()
//                tunnelLength = Int.random(in: 1...1000)
//            }
        }
        findPathsCycling(mazeProvider: mazeProvider)
    }
    
    func findPaths(mazeProvider: MazeProvider) {
        guard !activeCells.isEmpty else {
            return
        }
//        let randomIndex = Double.random(in: 0...1) < variation ? Int.random(in: 0..<activeCells.count) : activeCells.count-1
//        let randomIndex = cellCount < 500 ? Int.random(in: 0..<activeCells.count) : activeCells.count-1
        let randomIndex = 0
        let cell = activeCells[randomIndex]
        let neighbors = mazeProvider.neighborsFor(cell.location).filter{ $0.data as? String ?? "" != VISITED}
        
        if neighbors.isEmpty {
            activeCells.remove(at: randomIndex)
        } else {
            if let otherCell = neighbors.randomElement() {
                mazeProvider.setWall(cell1: cell, cell2: otherCell, wallState: .open)
                otherCell.setData(VISITED)
                cellCount += 1
                
                activeCells.remove(at: 0)
                activeCells.append(cell)
                activeCells.append(otherCell)
            }
//            if cellCount%tunnelLength == 0 {
//                activeCells.shuffle()
//                tunnelLength = Int.random(in: 1...1000)
//            }
        }
        findPaths(mazeProvider: mazeProvider)
    }
    
    func simplifiedFindPaths(mazeProvider: MazeProvider) {
        guard !activeCells.isEmpty else {
            return
        }
        let randomIndex = Int.random(in: 0..<activeCells.count)
        let cell = activeCells[randomIndex]
        let neighbors = mazeProvider.neighborsFor(cell.location).filter{ $0.data as? String ?? "" != VISITED}
        
        if neighbors.isEmpty {
            activeCells.remove(at: randomIndex)
        } else {
            if let otherCell = neighbors.randomElement() {
                mazeProvider.setWall(cell1: cell, cell2: otherCell, wallState: .open)
                otherCell.setData(VISITED)
                activeCells.append(otherCell)
            }
        }
        simplifiedFindPaths(mazeProvider: mazeProvider)
    }
    
    func primsToBackTrace(mazeProvider: MazeProvider) {
        guard !activeCells.isEmpty else {
            return
        }
        let randomIndex = cellCount < mazeProvider.numberCells/2 ? Int.random(in: 0..<activeCells.count) : max(0, activeCells.count-1)
        let cell = activeCells[randomIndex]
        let neighbors = mazeProvider.neighborsFor(cell.location).filter{ $0.data as? String ?? "" != VISITED}
        
        if neighbors.isEmpty {
            activeCells.remove(at: randomIndex)
        } else {
            if let otherCell = neighbors.randomElement() {
                mazeProvider.setWall(cell1: cell, cell2: otherCell, wallState: .open)
                otherCell.setData(VISITED)
                activeCells.append(otherCell)
                cellCount += 1
            }
        }
        primsToBackTrace(mazeProvider: mazeProvider)
    }
    
    func backtraceToPrims(mazeProvider: MazeProvider) {
        guard !activeCells.isEmpty else {
            return
        }
        let randomIndex = cellCount > mazeProvider.numberCells/2 ? Int.random(in: 0..<activeCells.count) : max(0, activeCells.count-1)
        let cell = activeCells[randomIndex]
        let neighbors = mazeProvider.neighborsFor(cell.location).filter{ $0.data as? String ?? "" != VISITED}
        
        if neighbors.isEmpty {
            activeCells.remove(at: randomIndex)
        } else {
            if let otherCell = neighbors.randomElement() {
                mazeProvider.setWall(cell1: cell, cell2: otherCell, wallState: .open)
                otherCell.setData(VISITED)
                activeCells.append(otherCell)
                cellCount += 1
            }
        }
        primsToBackTrace(mazeProvider: mazeProvider)
    }
    
    func centerPrims(mazeProvider: MazeProvider) {
        guard !activeCells.isEmpty else {
            return
        }
        let randomIndex = 0
        let cell = activeCells[randomIndex]
        var neighbors = mazeProvider.neighborsFor(cell.location).filter{ $0.data as? String ?? "" != VISITED}.shuffled()
        neighbors.partition { $0.y < 10 }
        if neighbors.isEmpty {
            activeCells.remove(at: randomIndex)
        } else {
            if let otherCell = neighbors.first {
                mazeProvider.setWall(cell1: cell, cell2: otherCell, wallState: .open)
                otherCell.setData(VISITED)
                activeCells.append(otherCell)
            }
        }
        if cell.y < 10 {
            activeCells.shuffle()
        }
        centerPrims(mazeProvider: mazeProvider)
    }
}
