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
                        let points = tile.points.map{ $0 + offset(centerScreen) + displaySettings.distortion($0)}
                        path.move(to: points.first!)
                        path.addLines(points)
                    }.fill(blendColorForValue(value: tile.value))
                }
                
                Path { path in
                    for wall in displaySettings.mazeProvider.walls(centerScreen) {
                        path.move(
                            to: wall.start + offset(centerScreen) + displaySettings.distortion(wall.start)
                        )
                        path.addLine(
                            to: wall.end + offset(centerScreen) + displaySettings.distortion(wall.end)
                        )
                    }
                }.stroke(displaySettings.wallColor, lineWidth: displaySettings.wallWidth)
            }.padding()
        }
    }
    
    func offset(_ centerScreen: CGPoint) -> CGPoint {
        (displaySettings.mazeType == .square ? CGPoint.zero : centerScreen)
    }
    
    func blendColorForValue(value: Double) -> Color {
        
        guard value != .infinity, value != Double.nan else {
            return .white
        }
//       print(value)
        let (red, blue, green, color) = calcRGB(Int(value*10000.0), total: 10000, redWav: displaySettings.redWav, blueWav: displaySettings.blueWav, greenWav: displaySettings.greenWav)
        return color
//        return Color.init(red: displaySettings.color1.red*value + displaySettings.color2.red*value2,
//                          green: displaySettings.color1.green*value + displaySettings.color2.green*value2,
//                          blue: displaySettings.color1.blue*value + displaySettings.color2.blue*value2,
//                          opacity: 1)
    }
}

struct Tile {
    var id: String
    let points: [CGPoint]
    let value: Double
    
}

func calcRGB(_ index: Int,
              total: Double,
              redWav: (Double)->Double = {_ in 0},
              blueWav: (Double)->Double = {_ in 0},
              greenWav: (Double)->Double = {_ in 0}) -> (Double, Double, Double, Color) {
    let circ = Double.pi*2
    
    let theta = Double(index)/total*circ
    let red = (redWav(theta))
    let blue = (blueWav(theta))
    let green = (greenWav(theta))
    let color = Color(red: red, green: green, blue: blue, opacity: 1.0)
    
    return (red, blue, green, color)
}
