import Foundation

class PolarRow: Hashable {
    let col: Int
    let lastRow: Bool
    let multipleUpperNeighbors: Bool
    init(col: Int, cells: [PolarCell], lastRow: Bool = false, ringHeight: CGFloat, upperNeighbors: Bool) {
        self.col = col
        self.cells = cells
        self.lastRow = lastRow
        self.ringHeight = ringHeight
        self.multipleUpperNeighbors = upperNeighbors
    }
    
    let cells: [PolarCell]
    let ringHeight: CGFloat
    func walls(_ center: CGPoint) -> MazeData {
        
        return cells.reduce(MazeData(walls: [], tiles: []), { result, cell -> MazeData in
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
            
            var mazeData = MazeData(walls: [], tiles: [])
            if cell.leftBlocked {
                mazeData.walls.append(Wall(start: CGPoint(x: ax, y: ay), end: CGPoint(x: bx, y: by)))
            }
            
            if cell.bottomBlocked {
                mazeData.walls.append(Wall(start: CGPoint(x: ax, y: ay), end: CGPoint(x: cx, y: cy)))
            }
            
            if lastRow {
                mazeData.walls.append(Wall(start: CGPoint(x: bx, y: by), end: CGPoint(x: dx, y: dy)))
            }
            
            if !lastRow && multipleUpperNeighbors {
                let nextRadius = CGFloat(cell.col+2)*ringHeight
                let middleAngle = (CGFloat(cell.row) + 0.5)*theta
                let px = center.x + nextRadius*cos(middleAngle)
                let py = center.y + nextRadius*sin(middleAngle)
                mazeData.tiles.append(Tile(id: "\(cell.row)-\(cell.col)", points: [
                                            CGPoint(x: ax, y: ay),
                                            CGPoint(x: cx, y: cy),
                                            CGPoint(x: dx, y: dy),
                                            CGPoint(x: px, y: py),
                                            CGPoint(x: bx, y: by)], value: 1))
            } else {
                mazeData.tiles.append(Tile(id: "\(cell.row)-\(cell.col)", points: [
                                            CGPoint(x: ax, y: ay),
                                            CGPoint(x: cx, y: cy),
                                            CGPoint(x: dx, y: dy),
                                            CGPoint(x: bx, y: by)], value: 1))
            }
            
            return result + mazeData
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
