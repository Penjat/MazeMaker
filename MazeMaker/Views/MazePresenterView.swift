import SwiftUI

struct MazePresenterView: View {
    @StateObject var mazeProvider = SquareMaze(width: 36, height: 36)
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
                    for wall in mazeProvider.walls() {
                        path.move(
                            to: wall.start*cellSize
                        )
                        path.addLine(
                            to: wall.end*cellSize
                        )
                    }
                }.stroke(Color.black, lineWidth: 2)
            }.padding()
            Button("Recursive Backtrace") {
                mazeProvider.generateMaze()
            }
            Button("Binary Tree") {
                mazeProvider.generateBinaryMaze()
            }
        }
        
    }
}

struct MazePresenterView_Previews: PreviewProvider {
    static var previews: some View {
        MazePresenterView()
    }
}
