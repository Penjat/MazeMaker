import SwiftUI

import Foundation
#if os(iOS)
import UIKit
#endif

import Cocoa


struct MazePresenterView: View {
    @EnvironmentObject var displaySettings: MazeDisplaySettings
    @State private var percentage: CGFloat = .zero
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            GeometryReader { geometry in
                let centerScreen = CGPoint(x: geometry.size.width/2.0, y: geometry.size.height/2.0)
                ForEach(displaySettings.mazeProvider.tiles(centerScreen), id: \.self.id) { tile in
                    Path { path in
                        let points = tile.points.map{ $0 + offset(centerScreen)}
                        path.move(to: points.first!)
                        path.addLines(points)
                    }.fill(blendColorForValue(value: tile.value))
                }
                
                Path { path in
                    for wall in displaySettings.mazeProvider.walls(centerScreen) {
                        path.move(
                            to: wall.start + offset(centerScreen)
                        )
                        path.addLine(
                            to: wall.end + offset(centerScreen)
                        )
                    }
                }.stroke(displaySettings.wallColor.color, lineWidth: displaySettings.wallWidth)
            }.padding()
        }
    }
    
    func offset(_ centerScreen: CGPoint) -> CGPoint {
        (displaySettings.mazeType == .square ? CGPoint.zero : centerScreen)
    }
    
    
    
    func blendColorForValue(value: Double) -> Color {
        
        guard value != .infinity else {
            return .white
        }
       print(value)
        let (red, blue, green, color) = calcRGB(Int(value*100), total: 100)
        return color
//        return Color.init(red: displaySettings.color1.red*value + displaySettings.color2.red*value2,
//                          green: displaySettings.color1.green*value + displaySettings.color2.green*value2,
//                          blue: displaySettings.color1.blue*value + displaySettings.color2.blue*value2,
//                          opacity: 1)
    }
    
    
    func calcRGB(_ index: Int, total: Double, wav: (Double)->Double = sin) -> (Double, Double, Double, Color) {
        let offset1 = Double.pi*2/3*2
        let offset2 = Double.pi*2/3
        let circ = Double.pi*2
        
        let theta = Double(index)/total*circ
        let red = (wav(theta)+1)/2
        let blue = (wav(theta + offset1)+1)/2
        let green = (wav(theta + offset2)+1)/2
        let color = Color(red: red, green: green, blue: blue, opacity: 1.0)
        
        return (red, blue, green, color)
    }
}

struct Tile {
    var id: String
    let points: [CGPoint]
    let value: Double
    
}
