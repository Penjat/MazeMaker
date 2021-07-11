import Foundation

class PolarCell: Hashable {
    var hashValue: Int {
            return ObjectIdentifier(self).hashValue
        }
    
    static func ==(lhs: PolarCell, rhs: PolarCell) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    let col: Int
    let row: Int
    let isOpen: Bool
    
    var leftBlocked = true
    var bottomBlocked = true
    
    init(col: Int, row: Int, isOpen: Bool = false) {
        self.col = col
        self.row = row
        self.isOpen = isOpen
    }
}
