import SwiftUI

struct PolarMazeView: View {
    @EnvironmentObject var displaySettings: MazeDisplaySettings
    var polarRows: [PolarRow] {
        let polarMaze = displaySettings.mazeProvider as? PolarMazeProvider
        return polarMaze?.polarRows ?? []
    }
    let ringHeight: CGFloat = 20.0
    let rowSize: Int = 13
    var body: some View {
        GeometryReader { geometry in
            
            let centerScreen = CGPoint(x: geometry.size.width/2, y: geometry.size.height/2)
            ForEach(polarRows, id: \.self) { row in
                PolarRowView(row: row, centerScreen: centerScreen, ringHeight: ringHeight)
            }
        }.toolbar {
            ToolbarItem {
                Button("generate") {
//                    displaySettings.mazeProvider.recursiveBacktrace()
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
