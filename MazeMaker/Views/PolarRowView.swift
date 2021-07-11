import SwiftUI

struct PolarRowView: View {
    let row: PolarRow
    let centerScreen: CGPoint
    let ringHeight: CGFloat
    
    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).foregroundColor(.red)
        ForEach(row.cells, id: \.self) { cell in
            
            drawCell(cell)
        }
    }
    
    func drawCell(_ cell: PolarCell) -> some View {
        let theta = CGFloat.pi*2.0/CGFloat(row.cells.count)
        let angle1 = CGFloat(cell.row)*theta
        let angle2 = CGFloat(cell.row + 1)*theta
        let innerRadians = CGFloat(cell.col)*ringHeight
        let outerRadians = CGFloat(cell.col+1)*ringHeight
        
        let ax = centerScreen.x + innerRadians*cos(angle1)
        let ay = centerScreen.y + innerRadians*sin(angle1)
        let bx = centerScreen.x + outerRadians*cos(angle1)
        let by = centerScreen.y + outerRadians*sin(angle1)
        
        //                let cx = centerScreen.x + innerRadians*cos(angle2)
        //                let cy = centerScreen.y + innerRadians*sin(angle2)
        //                let dx = centerScreen.x + outerRadians*cos(angle2)
        //                let dy = centerScreen.y + outerRadians*sin(angle2)
        return Group {
            if !cell.bottomBlocked {
                AnyView(PolarBottomWall(centerScreen: centerScreen, angle1: angle1, angle2: angle2, innerRadians: innerRadians, outerRadians: outerRadians))
            }
            if !cell.leftBlocked {
                Path { path in
                    path.move(to: CGPoint(x: ax, y: ay))
                    path.addLines([CGPoint(x: ax, y: ay),CGPoint(x: bx, y: by)])
                }.stroke(Color.red, lineWidth: 4)
            }
        }
        
        
            

    }
    
//    func leftWall(cell: PolarCell) -> Path? {
//        if !cell.bottomBlocked {
//            return Path { path in
//                path.addArc(center: centerScreen, radius: innerRadians, startAngle: Angle.init(radians: Double(angle1)), endAngle: Angle.init(radians: Double(angle2)), clockwise: false)
//            }.stroke(Color.red, lineWidth: 4)
//        }
//    }
}

struct PolarBottomWall: View {
    let centerScreen: CGPoint
    
    let angle1: CGFloat
    let angle2: CGFloat
    let innerRadians: CGFloat
    let outerRadians: CGFloat
    
    var body: some View {
        return AnyView(Path { path in
            path.addArc(center: centerScreen, radius: innerRadians, startAngle: Angle.init(radians: Double(angle1)), endAngle: Angle.init(radians: Double(angle2)), clockwise: false)
        }.stroke(Color.red, lineWidth: 4))
    }
}

//struct PolarRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        PolarRowView(row: PolarRow(cells: <#T##[PolarCell]#>))
//    }
//}
