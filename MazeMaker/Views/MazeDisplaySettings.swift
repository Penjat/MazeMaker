import Foundation
import Combine

class MazeDisplaySettings: ObservableObject {
    @Published var color1: ColorOutput = ColorOutput(color: .white, red: 1.0, green: 1.0, blue: 1.0)
    @Published var color2: ColorOutput = ColorOutput(color: .blue, red: 0.0, green: 0.0, blue: 1.0)
    @Published var wallColor: ColorOutput = ColorOutput(color: .black, red: 0.0, green: 0.0, blue: 0.0)
    @Published var wallWidth: CGFloat = 2.0
    @Published var mazeProvider: MazeProvider = PolarMazeProvider(wallHeight: 10, startingCells: 5, columns: 30)//SquareMaze(width: 22, height: 22, wallHeight: 16)
    @Published var mazeType: MazeType = .polar
    @Published var wallSize: CGFloat = 20
    @Published var redWav: (Double) -> Double = {sin($0)}
    @Published var blueWav: (Double) -> Double = {sin($0)}
    @Published var greenWav: (Double) -> Double = {sin($0)}
    
    @Published var distortionXX: (Double) -> Double = {_ in 0}
    @Published var distortionYY: (Double) -> Double = {_ in 0}
    @Published var distortionXY: (Double) -> Double = {_ in 0}
    @Published var distortionYX: (Double) -> Double = {_ in 0}
    
    lazy var distortion = { (point: CGPoint) -> CGPoint in
        let amt = 5.0
        let xDistortion = self.distortionXX(point.x)*amt
        let yDistortion = self.distortionYY(point.y)*amt
        return CGPoint(x: xDistortion, y: yDistortion)
        
//        return CGPoint.zero
    }
}
