import SwiftUI

struct DistortionControllerView: View {
    @EnvironmentObject var displaySettings: MazeDisplaySettings
    var body: some View {
        VStack {
            TabView {
                DistortionPage(wav: $displaySettings.distortionXX).tag(1)
                DistortionPage(wav: $displaySettings.distortionYY).tag(2)
                DistortionPage(wav: $displaySettings.distortionXY).tag(3)
                DistortionPage(wav: $displaySettings.distortionYX).tag(4)
            }
        }
    }
}

struct DistortionControllerView_Previews: PreviewProvider {
    static var previews: some View {
        DistortionControllerView()
    }
}
