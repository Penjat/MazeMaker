import Foundation

class PolarMazeProvider: ObservableObject {
    @Published var polarRows = [PolarRow]()
    
    init() {
        self.polarRows = createCells(ringHeight: 30)
    }
    
    func createCells(ringHeight: CGFloat) -> [PolarRow] {
        var rows = [PolarRow]()
        
        var numberCells =  8
        var numberColumns = 12
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
