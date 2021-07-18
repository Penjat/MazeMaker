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
                        let points = tile.points.map{ $0 + centerScreen}
                        path.move(to: points.first!)
                        path.addLines(points)
                    }.fill(blendColorForValue(value: tile.value))
                }
                
                Path { path in
                    for wall in displaySettings.mazeProvider.walls(centerScreen) {
                        path.move(
                            to: wall.start + centerScreen
                        )
                        path.addLine(
                            to: wall.end + centerScreen
                        )
                    }
                }.stroke(displaySettings.wallColor.color, lineWidth: displaySettings.wallWidth)
            }.padding()
        }
    }
    
    
    
    func blendColorForValue(value: Double) -> Color {
        let value2 = 1 - value
        
        return Color.init(red: displaySettings.color1.red*value + displaySettings.color2.red*value2,
                          green: displaySettings.color1.green*value + displaySettings.color2.green*value2,
                          blue: displaySettings.color1.blue*value + displaySettings.color2.blue*value2,
                          opacity: 1)
    }
}

struct Tile {
    var id: String
    let points: [CGPoint]
    let value: Double
    
}
