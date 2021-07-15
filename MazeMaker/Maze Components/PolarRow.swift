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
    let ringHeight: CGFloat = 10.0
    func walls(_ center: CGPoint) -> [Wall] {
        
        return cells.reduce([Wall](), { result, cell -> [Wall] in
            let theta = CGFloat.pi*2.0/CGFloat(cells.count)
            let angle1 = CGFloat(cell.row)*theta
            let angle2 = CGFloat(cell.row + 1)*theta
            let innerRadians = CGFloat(cell.col)*ringHeight
            let outerRadians = CGFloat(cell.col+1)*ringHeight
            
            let ax = center.x + innerRadians*cos(angle1)
            let ay = center.y + innerRadians*sin(angle1)
            let bx = center.x + outerRadians*cos(angle1)
            let by = center.y + outerRadians*sin(angle1)
            
            let cx = center.x + innerRadians*cos(angle2)
            let cy = center.y + innerRadians*sin(angle2)
            let dx = center.x + outerRadians*cos(angle2)
            let dy = center.y + outerRadians*sin(angle2)
            
            var walls = [Wall]()
            if cell.leftBlocked {
                walls.append(Wall(start: CGPoint(x: ax, y: ay), end: CGPoint(x: bx, y: by)))
            }
            
            if cell.bottomBlocked {
                walls.append(Wall(start: CGPoint(x: ax, y: ay), end: CGPoint(x: cx, y: cy)))
            }
            
            if lastRow {
                walls.append(Wall(start: CGPoint(x: bx, y: by), end: CGPoint(x: dx, y: dy)))
            }
            
            return result + walls
        })
    }
    
    var hashValue: Int {
        return ObjectIdentifier(self).hashValue
    }
    
    static func ==(lhs: PolarRow, rhs: PolarRow) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}



//let theta = CGFloat.pi*2.0/CGFloat(cells.count)
//let angle1 = CGFloat(cell.row)*theta
//let angle2 = CGFloat(cell.row + 1)*theta
//let innerRadians = CGFloat(cell.col)*ringHeight
//let outerRadians = CGFloat(cell.col+1)*ringHeight
//
//let ax = center.x + innerRadians*cos(angle1)
//let ay = center.y + innerRadians*sin(angle1)
//let bx = center.x + outerRadians*cos(angle1)
//let by = center.y + outerRadians*sin(angle1)
//
//let cx = center.x + innerRadians*cos(angle2)
//let cy = center.y + innerRadians*sin(angle2)
//let dx = center.x + outerRadians*cos(angle2)
//let dy = center.y + outerRadians*sin(angle2)
//return Wall(start: CGPoint(x: ax, y: ay), end: CGPoint(x: bx, y: by))
