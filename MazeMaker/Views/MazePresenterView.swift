import SwiftUI

struct MazePresenterView: View {
    @StateObject var mazeProvider = SquareMaze(width: 30, height: 30)
    let cellSize: CGFloat = 20.0
    var body: some View {
        VStack {
            GeometryReader { geometry in
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
            Button("Generate") {
                mazeProvider.generateMaze()
            }
        }
        
    }
}

struct MazePresenterView_Previews: PreviewProvider {
    static var previews: some View {
        MazePresenterView()
    }
}
