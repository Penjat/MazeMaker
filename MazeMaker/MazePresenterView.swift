import SwiftUI

struct MazePresenterView: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                path.move(
                    to: CGPoint(
                        x: 0,
                        y: 0
                    )
                )
                path.addLine(
                    to: CGPoint(
                        x: 200,
                        y: 200
                    )
                )
            }.stroke(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/), lineWidth: 4)
        }
    }
}

struct MazePresenterView_Previews: PreviewProvider {
    static var previews: some View {
        MazePresenterView()
    }
}
