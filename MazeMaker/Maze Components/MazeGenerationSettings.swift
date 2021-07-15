import Combine

class MazeGenerationSettings: ObservableObject {
    @Published var mazeWidth: Int = 0
    @Published var mazeHeight: Int = 0
}
