import SwiftUI

enum SideBarTab: String, CaseIterable {
    case generate
    case distort
}

struct SideBar: View {
    @EnvironmentObject var displaySettings: MazeDisplaySettings
    @State var color1: Color = .blue
    @State var showSetSize = true
    @State var tab: SideBarTab = .generate
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20){
                Picker(selection: $tab, label: Text(tab.rawValue)) {
                    ForEach(SideBarTab.allCases, id: \.rawValue) { tabType in
                        Text("\(tabType.rawValue)").tag(tabType)
                    }
                }
                tabView
                
                stats
                
                Button("Binary Tree") {
                    print("pressed button")
                    guard let mazeProvider = displaySettings.mazeProvider as? SquareMaze else {
                        return
                    }
                    mazeProvider.generateBinaryMaze()
                }.disabled(displaySettings.mazeType != .square)
                Group {
                    Divider()
                    Button("Recursive Backtrace") {
                        print("backtrace")
                        displaySettings.mazeProvider.clearData()
                        displaySettings.mazeProvider.clearAll()
                        RecursiveBacktraceGenertor.generate(mazeProvider: displaySettings.mazeProvider)
                        displaySettings.mazeProvider.clearData()
                        
                        let ds = DijkstraService()
                        ds.findFurthest(mazeProvider: displaySettings.mazeProvider)
                        displaySettings.mazeProvider.longest = ds.longestPath
                        displaySettings.mazeProvider.generateMazeData()
                        
                    }
                    //                    Slider(
                }
                Group {
                    Button("Prims Simplified") {
                        //                    mazeProvider.generateSimplifiedPrimsMaze()
                        displaySettings.mazeProvider.clearData()
                        displaySettings.mazeProvider.clearAll()
                        let prims = PrimsMazeGenerator()
                        prims.activeCells.append(displaySettings.mazeProvider.randomCell()!)
//                        prims.simplifiedFindPaths(mazeProvider: displaySettings.mazeProvider)
                        prims.findPathsCycling(mazeProvider: displaySettings.mazeProvider)
                        displaySettings.mazeProvider.clearData()
                        
                        let ds = DijkstraService()
                        ds.findFurthest(mazeProvider: displaySettings.mazeProvider)
                        displaySettings.mazeProvider.longest = ds.longestPath
                        displaySettings.mazeProvider.generateMazeData()
                    }
                    
                    Button("Backtrace to Prims") {
                        print("pressed button")
                        displaySettings.mazeProvider.clearData()
                        displaySettings.mazeProvider.clearAll()
                        let prims = PrimsMazeGenerator()
                        prims.activeCells.append(displaySettings.mazeProvider.randomCell()!)
                        prims.backtraceToPrims(mazeProvider: displaySettings.mazeProvider)
                        displaySettings.mazeProvider.clearData()
                        
                        let ds = DijkstraService()
                        ds.findFurthest(mazeProvider: displaySettings.mazeProvider)
                        displaySettings.mazeProvider.longest = ds.longestPath
                        displaySettings.mazeProvider.generateMazeData()
                    }
                    
                    Button("Prims to Backtrace") {
                        print("pressed button")
                        displaySettings.mazeProvider.clearData()
                        displaySettings.mazeProvider.clearAll()
                        let prims = PrimsMazeGenerator()
                        prims.activeCells.append(displaySettings.mazeProvider.randomCell()!)
                        prims.primsToBackTrace(mazeProvider: displaySettings.mazeProvider)
                        displaySettings.mazeProvider.clearData()
                        
                        let ds = DijkstraService()
                        ds.findFurthest(mazeProvider: displaySettings.mazeProvider)
                        displaySettings.mazeProvider.longest = ds.longestPath
                        displaySettings.mazeProvider.generateMazeData()
                    }
                    
                    Button("Center Prims") {
                        //                    mazeProvider.generateSimplifiedPrimsMaze()
                        displaySettings.mazeProvider.clearData()
                        displaySettings.mazeProvider.clearAll()
                        let prims = PrimsMazeGenerator()
                        prims.activeCells.append(displaySettings.mazeProvider.randomCell()!)
                        prims.centerPrims(mazeProvider: displaySettings.mazeProvider)
                        displaySettings.mazeProvider.clearData()
                        
                        let ds = DijkstraService()
                        ds.findFurthest(mazeProvider: displaySettings.mazeProvider)
                        displaySettings.mazeProvider.longest = ds.longestPath
                        displaySettings.mazeProvider.generateMazeData()
                    }
                    
                    RBGControllerView()
                    WaveBowView(redWav: displaySettings.redWav, blueWav: displaySettings.blueWav, greenWav: displaySettings.greenWav)
                    HStack {
                        ColorPicker("wall", selection: $displaySettings.wallColor)
                        Slider(value: $displaySettings.wallWidth, in: 0.0...14.0) {
                            
                        }
                    }
                    Spacer()
                }
            }
        }.frame(width:800).padding()
    }
    
    var tabView: some View {
        switch tab {
        case .generate:
            return AnyView(MazeSizeView())
        case .distort:
            return AnyView(DistortionControllerView())
        }
    }
    
    var stats: some View {
        VStack {
            //            Text("\(mazeProvider.deadEnds) dead ends.")
            //            Text("\(mazeProvider.hallways) hallways")
            //            Text("\(mazeProvider.threeWayJunctions) three way junctions.")
            //            Text("\(mazeProvider.fourWayJunctions) four way junctions.")
        }
    }
    
    func saveMaze() {
        let nsView = NSHostingView(rootView: MazePresenterView())
        let bitmapRep = nsView.bitmapImageRepForCachingDisplay(in: nsView.bounds)!
        bitmapRep.size = nsView.bounds.size
        bitmapRep.canBeCompressed(using: .jpeg)
        nsView.cacheDisplay(in: nsView.bounds, to: bitmapRep)
        
        let data = bitmapRep.bitmapData
    }
}
