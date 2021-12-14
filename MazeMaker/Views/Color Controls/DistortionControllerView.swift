import SwiftUI

struct DistortionControllerView: View {
    @EnvironmentObject var displaySettings: MazeDisplaySettings
    
    var body: some View {
//        TabView {
//            <#code#>
//        }
        VStack {
            WaveMakerView(wav: $displaySettings.distortionXX)
            WaveMakerView(wav: $displaySettings.distortionYY)
            
        }
    }
}

struct DistortionControllerView_Previews: PreviewProvider {
    static var previews: some View {
        DistortionControllerView()
    }
}
