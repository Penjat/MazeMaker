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
    let ringHeight: CGFloat = 1.0
    func walls(_ center: CGPoint) -> [Wall] {
        return cells.map { cell in
            let theta = CGFloat.pi*2.0/CGFloat(cells.count)
            let angle1 = CGFloat(cell.row)*theta
            let angle2 = CGFloat(cell.row + 1)*theta
            let innerRadians = CGFloat(cell.col)*ringHeight
            let outerRadians = CGFloat(cell.col+1)*ringHeight
            
            let ax = center.x + innerRadians*cos(angle1)
            let ay = center.y + innerRadians*sin(angle1)
            let bx = center.x + outerRadians*cos(angle1)
            let by = center.y + outerRadians*sin(angle1)
            
            //                let cx = centerScreen.x + innerRadians*cos(angle2)
            //                let cy = centerScreen.y + innerRadians*sin(angle2)
            //                let dx = centerScreen.x + outerRadians*cos(angle2)
            //                let dy = centerScreen.y + outerRadians*sin(angle2)
            return Wall(start: CGPoint(x: ax, y: ay), end: CGPoint(x: bx, y: by))
            
        }
    }
    
    var hashValue: Int {
        return ObjectIdentifier(self).hashValue
    }
    
    static func ==(lhs: PolarRow, rhs: PolarRow) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}
