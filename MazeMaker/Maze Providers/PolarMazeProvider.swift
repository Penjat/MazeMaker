import Foundation

class PolarMazeProvider: ObservableObject, MazeProvider {
    @Published var polarRows = [PolarRow]()
    var longest = 0
    var tiles = [Tile]()
    var walls = [Wall]()
    var numberCells: Int {
        return polarRows.map{ $0.cells}.flatMap{}.count
    }
    
    init(wallHeight: CGFloat, startingCells: Int, columns: Int) {
        print("creating cells")
        self.polarRows = createCells(ringHeight: wallHeight, startingCells: startingCells, numberColumns: columns)
        
        print("Generating maze")
//        RecursiveBacktraceGenertor.generate(mazeProvider: self)
        
        let prims = PrimsMazeGenerator()
        prims.activeCells.append(randomCell()!)
        prims.simplifiedFindPaths(mazeProvider: self)
//        prims()
        //generate data
        clearData()
        let djService = DijkstraService()
        djService.findFurthest(mazeProvider: self)
        longest = djService.longestPath
        generateMazeData()
    }
    
    
    func tiles(_ center: CGPoint) -> [Tile] {
        return tiles
    }
    
    func walls(_ center: CGPoint) -> [Wall] {
        return walls
//        let walls = polarRows.flatMap { $0.walls(center) }
//        print("# walls: \(walls.count)")
//        return walls
        
    }
    
    func generateMazeData() {
        let mazeData = polarRows.reduce(MazeData(walls: [], tiles: [])) { result, polarRow in
            return result + polarRow.walls(CGPoint.zero, longestDepth: longest)
        }
        walls = mazeData.walls
        tiles = mazeData.tiles
    }
    
    func recursiveBacktrace() {
        print("generating maze")
        clearData()
        RecursiveBacktraceGenertor.generate(mazeProvider: self)
    }
    
    func prims() {
        
        let prims = PrimsMazeGenerator()
        let startingCell = randomCell()!
        prims.activeCells.append(startingCell)
        prims.primsToBackTrace(mazeProvider: self)
    }
    
    func clearData() {
        for row in polarRows {
            for cell in row.cells {
                cell.setData(nil)
            }
        }
    }
    
    func freeNeighbors(_ cellLocation: CellLocation) -> [Cell] {
        neighborsFor(cellLocation).filter{ cell in
            guard let cell = cell as? PolarCell, let currentCell = cellAt(cellLocation) as? PolarCell else {
                return false
            }
            
            if cell.y == cellLocation.y {
                if cell.x == cellLocation.x+1 {
                    return !cell.leftBlocked
                }
                
                if cell.x+1 == cellLocation.x {
                    return !currentCell.leftBlocked
                }
                return cell.x < cellLocation.x ? !cell.leftBlocked : !currentCell.leftBlocked
            }
            
            if cell.y < cellLocation.y {
                return !currentCell.bottomBlocked
            }
            
            if cell.y > cellLocation.y {
                return !cell.bottomBlocked
            }
            return false
        }
    }
    
    func neighborsFor(_ cellLocation: CellLocation) -> [Cell] {
        var neighbors = [Cell?]()
        neighbors.append(cellAt(CellLocation(x: cellLocation.x+1, y: cellLocation.y)))
        neighbors.append(cellAt(CellLocation(x: cellLocation.x-1, y: cellLocation.y)))
        
        if let upperRow = rowAt(cellLocation.y+1) {
            let upperScalar = upperRow.cells.count / polarRows[cellLocation.y].cells.count
            let newNeighbors = upperRow.cells.filter { cell in
                cellLocation.x == cell.row / upperScalar
            }
            for neighbor in newNeighbors {
                neighbors.append(neighbor)
            }
        }
        
        if let lowerRow = rowAt(cellLocation.y-1) {
            let lowerScalar =   polarRows[cellLocation.y].cells.count / lowerRow.cells.count
            let newNeighbors = lowerRow.cells.filter { cell in
                cell.row == cellLocation.x / lowerScalar
            }
            for neighbor in newNeighbors {
                neighbors.append(neighbor)
            }
        }
        
        return neighbors.compactMap{$0}
    }
    
    func setWall(cell1: Cell, cell2: Cell, wallState: WallState) {
        guard let polarCell1 = cell1 as? PolarCell, let polarCell2 = cell2 as? PolarCell else {
            return
        }
        
        if (polarCell1.col == polarCell2.col), ((polarCell1.row + 1)%(polarRows[polarCell1.col].cells.count)) == polarCell2.row {
            print("are left right")
            polarCell2.leftBlocked = (wallState == .blocked)
            return
        }
        
        if polarCell1.col == polarCell2.col, ((polarCell2.row + 1)%(polarRows[polarCell2.col].cells.count)) == polarCell1.row {
            print("are right left")
            polarCell1.leftBlocked = (wallState == .blocked)
            return
        }
        
        if polarCell1.col + 1 == polarCell2.col {
            //is below above
            print("are below above")
            let rowSizeScalar = polarRows[polarCell2.col].cells.count / polarRows[polarCell1.col].cells.count
            if polarCell1.row == polarCell2.row / rowSizeScalar {
                polarCell2.bottomBlocked = (wallState == .blocked)
            } else {
                print("not connected \(polarCell1.row) ")
                print("scalar \(rowSizeScalar) ")
                print("not connected \(polarCell2.row / rowSizeScalar) ")
            }
            return
        }
        
        if polarCell1.col == polarCell2.col + 1 {
            //is above below
            print("are above BELOW")
            let rowSizeScalar = polarRows[polarCell1.col].cells.count / polarRows[polarCell2.col].cells.count
            if polarCell2.row == polarCell1.row / rowSizeScalar {
                polarCell1.bottomBlocked = (wallState == .blocked)
            }
            return
        }
        
    }
    
    func clearAll() {
        walls = []
        tiles = []
        for row in polarRows {
            for cell in row.cells {
                cell.leftBlocked = true
                cell.bottomBlocked = true
            }
        }
    }
    
    func cellAt(_ cellLocation: CellLocation) -> Cell? {
        if polarRows == nil {
            
        }
        guard cellLocation.y < polarRows.count, cellLocation.y >= 0 else {
            return nil
        }
        
//        print("y is \(cellLocation.y)")
//        print("finding for \(cellLocation)")
        let row = polarRows[cellLocation.y]
        
        if cellLocation.x == -1 {
            return row.cells.last
        }
        return row.cells[cellLocation.x%(row.cells.count)]
    }
    
    func rowAt(_ y: Int) -> PolarRow? {
        guard y < polarRows.count, y >= 0 else {
            return nil
        }
        return polarRows[y]
    }
    
    func randomCell() -> Cell? {
        return polarRows.randomElement()?.cells.randomElement() as? Cell
    }
    
    func createCells(ringHeight: CGFloat, startingCells: Int, numberColumns: Int) -> [PolarRow] {
        var rows = [PolarRow]()
        
        var rowSize =  startingCells
        for column in 0..<numberColumns {
            //            let innerRadians = CGFloat(col)*ringHeight
            let col = CGFloat(column)
            
            print("column is: \(column) - \(rowSize) cells")
            var cells = [PolarCell]()
            for row in 0..<rowSize {
                cells.append(PolarCell(col: column, row: row))
            }
            let lastRow = column == (numberColumns-1)
            
            
            
            let rowArea = CGFloat.pi*CGFloat(ringHeight*col)*CGFloat(ringHeight*col) - CGFloat.pi*CGFloat(ringHeight*(col-1))*CGFloat(ringHeight*(col-1))
            let idealCellArea = ringHeight*ringHeight
            var upperNeighbors = false
            if rowArea/CGFloat(rowSize) > idealCellArea*2 {
                rowSize = rowSize*2
                upperNeighbors = true
            }
            let polarRow = PolarRow(col: column , cells: cells, lastRow: lastRow, ringHeight: ringHeight, upperNeighbors: upperNeighbors)
            
            rows.append(polarRow)
        }
        return rows
    }
}
