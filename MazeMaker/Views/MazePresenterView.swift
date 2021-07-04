import SwiftUI

struct MazePresenterView: View {
    @EnvironmentObject var mazeProvider: SquareMaze
    @State private var percentage: CGFloat = .zero
    @State var color1: ColorOutput = ColorOutput(color: .white, red: 1.0, green: 1.0, blue: 1.0)
    @State var color2: ColorOutput = ColorOutput(color: .blue, red: 0.0, green: 0.0, blue: 1.0)
    @State var wallColor: ColorOutput = ColorOutput(color: .black, red: 0.0, green: 0.0, blue: 0.0)
    @State var wallWidth: CGFloat = 2.0
    let cellSize: CGFloat = 10.0
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack {
                stats
                ColorPicker(outputColor: $color1)
                ColorPicker(outputColor: $color2)
                ColorPicker(outputColor: $wallColor)
                Slider(value: $wallWidth, in: 0.0...14.0) {
                    
                }
            }.padding()
            
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
                }.stroke(wallColor.color, lineWidth: wallWidth)
                .toolbar {
                    
                }
            }.padding()
        }
    }
    
    var stats: some View {
        VStack {
            Text("\(mazeProvider.deadEnds) dead ends.")
            Text("\(mazeProvider.hallways) hallways")
            Text("\(mazeProvider.threeWayJunctions) three way junctions.")
            Text("\(mazeProvider.fourWayJunctions) four way junctions.")
        }
    }
    
    func blendColorForValue(value: Double) -> Color {
        let value2 = 1 - value
        
        return Color.init(red: color1.red*value + color2.red*value2,
                                                green: color1.green*value + color2.green*value2,
                                                              blue: color1.blue*value + color2.blue*value2,
                                    opacity: 1)
    }
}
