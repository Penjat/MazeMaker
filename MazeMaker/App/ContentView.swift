import SwiftUI

struct ContentView: View {
    @StateObject var mazeProvider = SquareMaze(width: 80, height: 60)
    var body: some View {
        NavigationView {
            SideBar()
            MazePresenterView().background(Color.blue)
        }.environmentObject(mazeProvider)
        //.frame(width: 800, height: 800)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
