import SwiftUI

struct PolarMazeView: View {
    let ringHeight: CGFloat = 40.0
    let myCell = PolarCell(col: 1, row: 2)
    let rowSize: Int = 13
    var body: some View {
        GeometryReader { geometry in
            let rows = createCells()
            let centerScreen = CGPoint(x: geometry.size.width/2, y: geometry.size.height/2)
            ForEach(rows, id: \.self) { row in
                PolarRowView(row: row, centerScreen: centerScreen, ringHeight: ringHeight)
            }
        }
    }
    
    func createCells() -> [PolarRow] {
        var rows = [PolarRow]()
        
        for column in 0..<10 {
            //            let innerRadians = CGFloat(col)*ringHeight
            let col = CGFloat(column)
            let rowArea = CGFloat.pi*CGFloat(ringHeight*col)*CGFloat(ringHeight*col) - CGFloat.pi*CGFloat(ringHeight*(col-1))*CGFloat(ringHeight*(col-1))
            let idealCellArea = ringHeight*ringHeight
            let numberCells =  4 + Int(rowArea / idealCellArea)
            print("column is: \(column) - \(numberCells) cells")
            var cells = [PolarCell]()
            for row in 0..<numberCells {
                cells.append(PolarCell(col: column, row: row))
            }
            let polarRow = PolarRow(col: column , cells: cells)
            rows.append(polarRow)
        }
        return rows
    }
}

struct PolarMazeView_Previews: PreviewProvider {
    static var previews: some View {
        PolarMazeView()
    }
}
