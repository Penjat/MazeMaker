import Foundation

class SquareMaze {
    var grid = [[SquareCell]]()
    init(width: Int, height: Int) {
        for x in 0..<width {
            for y in 0..<height {
                grid[x][y] = SquareCell(x: x, y: y)
            }
        }
    }
    
//    func walls() -> [Wall] {
//        grid.flatMap { [SquareCell] in
//            <#code#>
//        }
}
