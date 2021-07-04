import SwiftUI

struct SideBar: View {
    @EnvironmentObject var mazeProvider: SquareMaze
    @EnvironmentObject var displaySettings: MazeDisplaySettings
    @State var color1: Color = .blue
    @State var showSetSize = true
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20){
                MazeSizeView()
                stats
                
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
                
                Button("Backtrace to Prims") {
                    print("pressed button")
                    mazeProvider.backtraceToPrims()
                }
                
                Button("Prims to Backtrace") {
                    print("pressed button")
                    mazeProvider.generatePrimsMaze()
                }
                HStack {
                    ColorPicker(outputColor: $displaySettings.color1)
                    ColorPicker(outputColor: $displaySettings.color2)
                }
                
                HStack {
                    ColorPicker(outputColor: $displaySettings.wallColor)
                    Slider(value: $displaySettings.wallWidth, in: 0.0...14.0) {
                        
                    }
                }
                Spacer()
                    
            }
        }.frame(width:200).padding()
    }
    
    var stats: some View {
        VStack {
            Text("\(mazeProvider.deadEnds) dead ends.")
            Text("\(mazeProvider.hallways) hallways")
            Text("\(mazeProvider.threeWayJunctions) three way junctions.")
            Text("\(mazeProvider.fourWayJunctions) four way junctions.")
        }
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

    
