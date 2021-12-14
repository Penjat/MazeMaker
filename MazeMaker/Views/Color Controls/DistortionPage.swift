import SwiftUI

struct DistortionPage: View {
    @Binding var wav: (Double) -> Double
    var body: some View {
        VStack {
            WaveView(frequency: 1.0, wav: wav, color: .blue)
            WaveMakerView(wav: $wav)
        }
    }
}

struct DistortionPage_Previews: PreviewProvider {
    static var previews: some View {
        DistortionPage(wav: .constant(sin))
    }
}
