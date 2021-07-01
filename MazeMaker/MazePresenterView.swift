import SwiftUI

struct MazePresenterView: View {
    let mazeProvider = SquareMaze(width: 20, height: 20)
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                for wall in mazeProvider.walls() {
                    path.move(
                        to: wall.start
                    )
                    path.addLine(
                        to: wall.end
                    )
                }
                
            }.stroke(Color.black, lineWidth: 1)
        }.padding()
    }
}

struct MazePresenterView_Previews: PreviewProvider {
    static var previews: some View {
        MazePresenterView()
    }
}
