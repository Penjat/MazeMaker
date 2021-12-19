import SwiftUI

struct PrimsConfigView: View {
    @EnvironmentObject var displaySettings: MazeDisplaySettings
    @State var tunnelLength = -1.0
    var body: some View {
        VStack {
            Text("Prims")
            Slider(value: $tunnelLength, in: -1.0...200) {
                Text("\(tunnelLength)")
            }
            Button("generate") {
                displaySettings.mazeProvider.clearData()
                displaySettings.mazeProvider.clearAll()
                let prims = PrimsMazeGenerator(tunnelLength: Int(tunnelLength))
                prims.activeCells.append(displaySettings.mazeProvider.randomCell()!)

                prims.findPathsCycling(mazeProvider: displaySettings.mazeProvider)
                displaySettings.mazeProvider.clearData()
                
                let ds = DijkstraService()
                ds.findFurthest(mazeProvider: displaySettings.mazeProvider)
                displaySettings.mazeProvider.longest = ds.longestPath
                displaySettings.mazeProvider.generateMazeData()
            }
        }.padding().border(Color.blue, width: 4.0)
        
    }
}

struct PrimsConfigView_Previews: PreviewProvider {
    static var previews: some View {
        PrimsConfigView()
    }
}
