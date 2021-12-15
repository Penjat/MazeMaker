import Foundation
import Combine
import SwiftUI

struct ColorOutput {
    let color: Color
    let red: Double
    let green: Double
    let blue: Double
}

class MazeDisplaySettings: ObservableObject {
    @Published var color1: ColorOutput = ColorOutput(color: .white, red: 1.0, green: 1.0, blue: 1.0)
    @Published var color2: ColorOutput = ColorOutput(color: .blue, red: 0.0, green: 0.0, blue: 1.0)
    @Published var wallColor: Color = .black
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
        let xDistortion = self.distortionXX(point.x/1000*Double.pi*2) + self.distortionXY(point.y/1000*Double.pi*2)
        let yDistortion = self.distortionYY(point.y/1000*Double.pi*2) + self.distortionYX(point.x/1000*Double.pi*2)
        return CGPoint(x: xDistortion, y: yDistortion)
        
//        return CGPoint.zero
    }
}
