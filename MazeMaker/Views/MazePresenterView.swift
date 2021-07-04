import SwiftUI

struct MazePresenterView: View {
    @EnvironmentObject var mazeProvider: SquareMaze
    @EnvironmentObject var displaySettings: MazeDisplaySettings
    @State private var percentage: CGFloat = .zero
    
    let cellSize: CGFloat = 10.0
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            GeometryReader { geometry in
                let tiles = mazeProvider.tiles()
                ForEach(0..<tiles.count) { x in
                    let tile = tiles[x]
                    Path { path in
                        path.addRect(tile.0*cellSize)
                    }.fill(blendColorForValue(value: tile.1))
                }
                
                Path { path in
                    for wall in mazeProvider.walls().shuffled() {
                        path.move(
                            to: wall.start*cellSize
                        )
                        path.addLine(
                            to: wall.end*cellSize
                        )
                    }
                }.stroke(displaySettings.wallColor.color, lineWidth: displaySettings.wallWidth)
                .toolbar {
                    
                }
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
