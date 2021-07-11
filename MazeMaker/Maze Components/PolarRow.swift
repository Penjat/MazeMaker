import Foundation

class PolarRow: Hashable {
    let col: Int
    init(col: Int, cells: [PolarCell]) {
        self.col = col
        self.cells = cells
    }
    
    let cells: [PolarCell]
    
    var hashValue: Int {
            return ObjectIdentifier(self).hashValue
        }
    
    static func ==(lhs: PolarRow, rhs: PolarRow) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}
