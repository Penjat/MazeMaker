import SwiftUI

struct PolarMazeView: View {
    @StateObject var mazeProvider = PolarMazeProvider()
    let ringHeight: CGFloat = 20.0
    let rowSize: Int = 13
    var body: some View {
        GeometryReader { geometry in
            
            let centerScreen = CGPoint(x: geometry.size.width/2, y: geometry.size.height/2)
            ForEach(mazeProvider.polarRows, id: \.self) { row in
                PolarRowView(row: row, centerScreen: centerScreen, ringHeight: ringHeight)
            }
        }.toolbar {
            ToolbarItem {
                Button("generate") {
                    mazeProvider.recursiveBacktrace()
                }
            }
        }
    }
}

struct PolarMazeView_Previews: PreviewProvider {
    static var previews: some View {
        PolarMazeView()
    }
}
