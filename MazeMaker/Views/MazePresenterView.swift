import SwiftUI

struct MazePresenterView: View {
    @EnvironmentObject var mazeProvider: SquareMaze
    @State private var percentage: CGFloat = .zero
    let cellSize: CGFloat = 20.0
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            GeometryReader { geometry in
                let tiles = mazeProvider.tiles()
                ForEach(0..<tiles.count) { x in
                    let tile = tiles[x]
                    Path { path in
                        path.addRect(tile.0*cellSize)
                    }.fill(tile.1)
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
                }.stroke(Color.black, lineWidth: 2)//.trim(from: 0.5-percentage, to: 0.5+percentage).stroke(Color.black, lineWidth: 2)
            }.padding()
        }
    }
}
