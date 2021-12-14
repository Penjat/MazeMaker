import SwiftUI

struct DistortionControllerView: View {
    @EnvironmentObject var displaySettings: MazeDisplaySettings
    
    var body: some View {
        VStack {
            WaveMakerView(wav: $displaySettings.distortionWav)
            
        }
    }
}

struct DistortionControllerView_Previews: PreviewProvider {
    static var previews: some View {
        DistortionControllerView()
    }
}
