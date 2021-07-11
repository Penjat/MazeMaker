import Foundation

class PolarRow: Hashable {
    let col: Int
    let lastRow: Bool
    init(col: Int, cells: [PolarCell], lastRow: Bool = false) {
        self.col = col
        self.cells = cells
        self.lastRow = lastRow
    }
    
    let cells: [PolarCell]
    
    var hashValue: Int {
            return ObjectIdentifier(self).hashValue
        }
    
    static func ==(lhs: PolarRow, rhs: PolarRow) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}
