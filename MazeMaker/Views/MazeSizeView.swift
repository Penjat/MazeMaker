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
        if expanded {
            return AnyView(
                VStack {
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
                                let squareMaze = SquareMaze(width: newWidth, height: newHeight)
                                    squareMaze.createGrid(width: newWidth, height: newHeight)
                                squareMaze.backtraceToPrims()
                                displaySettings.mazeProvider = squareMaze
                                
    //                            mazeProvider.generateMaze()
                                displaySettings.mazeType = mazeType
                            } else {
                                displaySettings.mazeProvider = PolarMazeProvider(wallHeight: CGFloat(wallSize), startingCells: newWidth, columns: newHeight)
                                displaySettings.wallSize = CGFloat(wallSize)
                            }
                            
                            
                        } label: {
                            Text("create")
                        }
                    }
                }
            )
        } else {
//            return AnyView(Text("\(mazeProvider.grid.count) x \(mazeProvider.grid[0].count)").onTapGesture {
            return AnyView(Text("Hi").onTapGesture {
            expanded = true
            })
        }
    }
}

struct MazeSizeView_Previews: PreviewProvider {
    static var previews: some View {
        MazeSizeView()
    }
}
