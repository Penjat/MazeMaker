import Foundation
import Combine

class MazeDisplaySettings: ObservableObject {
    @Published var color1: ColorOutput = ColorOutput(color: .white, red: 1.0, green: 1.0, blue: 1.0)
    @Published var color2: ColorOutput = ColorOutput(color: .blue, red: 0.0, green: 0.0, blue: 1.0)
    @Published var wallColor: ColorOutput = ColorOutput(color: .black, red: 0.0, green: 0.0, blue: 0.0)
    @Published var wallWidth: CGFloat = 2.0
}