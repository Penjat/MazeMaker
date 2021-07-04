import SwiftUI

struct MazeSizeView: View {
    @State var expanded = false
    @State var width: String = ""
    @State var height: String = ""
    @EnvironmentObject var mazeProvider: SquareMaze
    var body: some View {
        states.onAppear {
            width = "\(mazeProvider.grid.count)"
            height = "\(mazeProvider.grid[0].count)"
        }
    }
    
    var states: some View {
        if expanded {
            return AnyView(
                VStack {
                    HStack {
                        TextField("width", text: $width)
                        TextField("width", text: $height)
                    }
                    HStack {
                        Button {
                            expanded = false
                            width = "\(mazeProvider.grid.count)"
                            height = "\(mazeProvider.grid[0].count)"
                        } label: {
                            Text("cancel")
                        }
                        
                        Button {
                            guard let newWidth = Int(width), let newHeight = Int(height) else {
                                return
                            }
                            expanded = false
                            mazeProvider.createGrid(width: newWidth, height: newHeight)
                            mazeProvider.generateMaze()
                            
                        } label: {
                            Text("create")
                        }
                    }
                }
            )
        } else {
            return AnyView(Text("\(mazeProvider.grid.count) x \(mazeProvider.grid[0].count)").onTapGesture {
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
