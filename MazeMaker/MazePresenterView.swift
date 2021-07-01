import SwiftUI

struct MazePresenterView: View {
    let mazeProvider = SquareMaze(width: 20, height: 40)
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
                
            }.stroke(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/), lineWidth: 4)
        }.padding()
    }
}

struct MazePresenterView_Previews: PreviewProvider {
    static var previews: some View {
        MazePresenterView()
    }
}
