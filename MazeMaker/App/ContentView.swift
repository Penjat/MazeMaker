import SwiftUI

struct ContentView: View {
    @StateObject var mazeProvider = SquareMaze(width: 80, height: 60)
    var body: some View {
        HStack {
            SideBar()
            MazePresenterView().background(Color.blue)
        }.environmentObject(mazeProvider)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
