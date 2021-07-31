import Foundation

enum MazeType: Int {
    case square
    case polar
    var info: MazeInfo {
        switch self {
        case .square:
           return MazeInfo(name: "Square")
        case .polar:
            return MazeInfo(name: "Polar")
        }
    }
    
    struct MazeInfo {
        let name: String
    }
}
