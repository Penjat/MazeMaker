import SwiftUI

struct SideBar: View {
    @EnvironmentObject var mazeProvider: SquareMaze
    var body: some View {
        List {
            Button("Binary Tree") {
                print("pressed button")
                mazeProvider.generateBinaryMaze()
            }
            Button("Recursive Backtrace") {
                mazeProvider.generateMaze()
            }
        }.listStyle(SidebarListStyle())
    }
}

//struct SideBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SideBar()
//    }
//}
