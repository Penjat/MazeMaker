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
                ForEach(mazeProvider.tiles(), id: \.self) { tile in
                    Path { path in
                        path.addRect(CGRect(x: tile.x, y: tile.y, width: 1, height: 1)*cellSize)
                    }.fill(blendColorForValue(value: tile.value))
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

struct Tile: Hashable {
    let x: Int
    let y: Int
    let value: Double
}

