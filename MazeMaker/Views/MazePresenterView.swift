import SwiftUI

struct MazePresenterView: View {
    @StateObject var mazeProvider = SquareMaze(width: 36, height: 36)
    let cellSize: CGFloat = 20.0
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            GeometryReader { geometry in
                Path { path in
                    for tile in mazeProvider.tiles() {
                        path.addRect(tile.0*cellSize)
                    }
                }.fill(Color.white)
                
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
