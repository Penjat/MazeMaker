import SwiftUI

struct ContentView: View {
    @StateObject var displaySettings = MazeDisplaySettings()
    var body: some View {
        HStack {
            SideBar()
            if displaySettings.mazeType == .polar {
                PolarMazeView()
            } else {
                MazePresenterView()
            }
        }
        .environmentObject(displaySettings)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
