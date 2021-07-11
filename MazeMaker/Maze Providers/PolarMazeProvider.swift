import Foundation

class PolarMazeProvider: ObservableObject, MazeProvider {
    @Published var polarRows = [PolarRow]()
    
    init() {
        print("creating cells")
        self.polarRows = createCells(ringHeight: 20)
        
        print("Generating maze")
//        setWall(cell1: cellAt(CellLocation(x: 1, y: 1))!, cell2: cellAt(CellLocation(x: 0, y: 1))!, wallState: .open)
//        setWall(cell1: cellAt(CellLocation(x: 1, y: 1))!, cell2: cellAt(CellLocation(x: 1, y: 2))!, wallState: .open)
        RecursiveBacktraceGenertor.generate(mazeProvider: self)
    }
    
    func recursiveBacktrace() {
        print("generating maze")
        blancMaze()
        RecursiveBacktraceGenertor.generate(mazeProvider: self)
    }
    
    func blancMaze() {
        for row in polarRows {
            for cell in row.cells {
                cell.setData(nil)
                cell.leftBlocked = true
                cell.bottomBlocked = true
            }
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
//            neighbors = neighbors + newNeighbors
        }
        
        if let lowerRow = rowAt(cellLocation.y-1) {
            let lowerScalar =   polarRows[cellLocation.y].cells.count / lowerRow.cells.count
            let newNeighbors = lowerRow.cells.filter { cell in
                cell.row == cellLocation.x / lowerScalar
            }
            for neighbor in newNeighbors {
                neighbors.append(neighbor)
            }
//            neighbors = neighbors + newNeighbors
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
    
    
    
    
    
    func createCells(ringHeight: CGFloat) -> [PolarRow] {
        var rows = [PolarRow]()
        
        var numberCells =  3
        var numberColumns = 23
        for column in 0..<numberColumns {
            //            let innerRadians = CGFloat(col)*ringHeight
            let col = CGFloat(column)
            let rowArea = CGFloat.pi*CGFloat(ringHeight*col)*CGFloat(ringHeight*col) - CGFloat.pi*CGFloat(ringHeight*(col-1))*CGFloat(ringHeight*(col-1))
            let idealCellArea = ringHeight*ringHeight
            if rowArea/CGFloat(numberCells) > idealCellArea*2 {
                numberCells = numberCells*2
            }
            print("column is: \(column) - \(numberCells) cells")
            var cells = [PolarCell]()
            for row in 0..<numberCells {
                cells.append(PolarCell(col: column, row: row))
            }
            let lastRow = column == (numberColumns-1)
            let polarRow = PolarRow(col: column , cells: cells, lastRow: lastRow)
            rows.append(polarRow)
        }
        return rows
    }
}
