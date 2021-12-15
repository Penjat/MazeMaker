import SwiftUI

struct ContentView: View {
    @StateObject var displaySettings = MazeDisplaySettings()
    var body: some View {
        HStack {
            SideBar()
            MazePresenterView()
        }
        .environmentObject(displaySettings)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
