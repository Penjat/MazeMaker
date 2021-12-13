import SwiftUI

enum RBGValue: String, CaseIterable {
    case RED
    case BLUE
    case GREEN
}

struct RBGControllerView: View {
    typealias WaveForm = (Double) -> (Double)
    @EnvironmentObject var displaySettings: MazeDisplaySettings
    @State var selectedColor = RBGValue.RED
    var body: some View {
        VStack {
            Text(selectedColor.rawValue)
            TabView {
                WaveMakerView(wav: $displaySettings.redWav).id(RBGValue.RED)
                WaveMakerView(wav: $displaySettings.blueWav).id(RBGValue.BLUE)
                WaveMakerView(wav: $displaySettings.greenWav).id(RBGValue.GREEN)
            }
        }
    }
}

struct RBGControllerView_Previews: PreviewProvider {
    static var previews: some View {
        RBGControllerView()
    }
}
