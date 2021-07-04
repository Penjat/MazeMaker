import SwiftUI

struct ContentView: View {
    @StateObject var mazeProvider = SquareMaze(width: 80, height: 60)
    @StateObject var displaySettings = MazeDisplaySettings()
    var body: some View {
        HStack {
            SideBar()
            MazePresenterView().background(Color.blue)
        }.environmentObject(mazeProvider)
        .environmentObject(displaySettings)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
