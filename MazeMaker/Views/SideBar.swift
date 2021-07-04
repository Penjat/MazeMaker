import SwiftUI

struct SideBar: View {
    @EnvironmentObject var mazeProvider: SquareMaze
    @State var color1: Color = .blue
    var body: some View {
        VStack {
            Button("Binary Tree") {
                print("pressed button")
                mazeProvider.generateBinaryMaze()
            }
            Button("Recursive Backtrace") {
                mazeProvider.generateMaze()
            }
            Button("Prims Simplified") {
                mazeProvider.generateSimplifiedPrimsMaze()
            }
        }.frame(width:200)
    }
    
    func saveMaze() {
//        let nsView = NSHostingView(rootView: MazePresenterView())
//        let bitmapRep = nsView.bitmapImageRepForCachingDisplay(in: nsView.bounds)!
//        bitmapRep.size = nsView.bounds.size
//        nsView.cacheDisplay(in: nsView.bounds, to: bitmapRep)
//        let data = image.representation(using: .jpeg, properties: [:])
//        try data?.write(to: path)
    }
}

//extension View {
//    func snapshot() -> NSImage {
//        let controller = NSHostingController(rootView: self)
//        let view = controller.view
//
//        let targetSize = controller.view.intrinsicContentSize
//        view.bounds = CGRect(origin: .zero, size: targetSize)
//        
//
//    }
//}

//struct SideBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SideBar()
//    }
//}
