import SwiftUI

struct DistortionControllerView: View {
    @EnvironmentObject var displaySettings: MazeDisplaySettings
    
    var body: some View {
//
        TabView {
            WaveMakerView(wav: $displaySettings.distortionXX).tag(1)
            WaveMakerView(wav: $displaySettings.distortionYY).tag(2)
            WaveMakerView(wav: $displaySettings.distortionXY).tag(3)
            WaveMakerView(wav: $displaySettings.distortionYX).tag(4)
        }
    }
}

struct DistortionControllerView_Previews: PreviewProvider {
    static var previews: some View {
        DistortionControllerView()
    }
}
