import SwiftUI

struct ContentView: View {
    var body: some View {
        MazePresenterView().background(Color.blue).frame(width: 800, height: 800)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
