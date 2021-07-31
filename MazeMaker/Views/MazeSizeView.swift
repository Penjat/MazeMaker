import SwiftUI

struct MazeSizeView: View {
    @State var expanded = false
    @State var width: String = ""
    @State var height: String = ""
    @State var wallSize: String = ""
    @State var mazeType: MazeType = .square
    
    @EnvironmentObject var displaySettings: MazeDisplaySettings
    
    var body: some View {
        states.padding(40)
            .background(Color.blue)
            .onAppear {
                //            width = "\(mazeProvider.grid.count)"
                //            height = "\(mazeProvider.grid[0].count)"
                mazeType = displaySettings.mazeType
            }
    }
    
    var states: some View {
        VStack {
            if expanded {
                AnyView(expandedView)
            } else {
                //            return AnyView(Text("\(mazeProvider.grid.count) x \(mazeProvider.grid[0].count)").onTapGesture {
                AnyView(mazeSizeInfo.onTapGesture {
                    expanded = true
                })
            }
        }
    }
    
    var mazeSizeInfo: some View {
        Group {
            Text(displaySettings.mazeType.info.name)
            Text("\(displaySettings.mazeProvider.mazeSize.0)")
            Text("\(displaySettings.mazeProvider.mazeSize.1)")
        }
    }
    
    var expandedView: some View {
        Group {
            Picker("Maze Type", selection: $mazeType) {
                Text("Grid").tag(MazeType.square)
                Text("Polar").tag(MazeType.polar)
            }.pickerStyle(SegmentedPickerStyle())
            HStack {
                TextField("width", text: $width)
                TextField("width", text: $height)
                TextField("wall size", text: $wallSize)
            }
            HStack {
                Button {
                    expanded = false
                    //                            width = "\(mazeProvider.grid.count)"
                    //                            height = "\(mazeProvider.grid[0].count)"
                } label: {
                    Text("cancel")
                }
                
                Button {
                    guard let newWidth = Int(width), let newHeight = Int(height), let wallSize = Int(wallSize) else {
                        return
                    }
                    expanded = false
                    displaySettings.mazeType = mazeType
                    if mazeType == .square {
                        print("creating maze")
                        let squareMaze = SquareMaze(width: newWidth, height: newHeight, wallHeight: CGFloat(wallSize))
                        squareMaze.createGrid(width: newWidth, height: newHeight)
//                        squareMaze.backtraceToPrims()
//                        let djService = DijkstraService()
//                        //                                djService.findFurthest(mazeProvider: squareMaze)
//                        squareMaze.clearData()
//                        djService.findFurthest(mazeProvider: squareMaze)
                        displaySettings.mazeProvider = squareMaze
//
                                                    
                        
                    } else {
                        displaySettings.mazeProvider = PolarMazeProvider(wallHeight: CGFloat(wallSize), startingCells: newWidth, columns: newHeight)
                        displaySettings.wallSize = CGFloat(wallSize)
                    }
                    
                    
                } label: {
                    Text("create")
                }
            }
        }
    }
}

struct MazeSizeView_Previews: PreviewProvider {
    static var previews: some View {
        MazeSizeView()
    }
}
