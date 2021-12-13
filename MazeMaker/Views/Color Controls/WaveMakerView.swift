import SwiftUI
import Combine

class WaveMakerViewModel: ObservableObject {
    @Published var wav1: (Double) -> Double = {_ in 0}
    @Published var wav2: (Double) -> Double = {_ in 0}
    @Published var wav3: (Double) -> Double = {_ in 0}
    @Published var wav4: (Double) -> Double = {_ in 0}
}

struct WaveMakerView: View {
    @Binding var wav: (Double) -> Double
    @StateObject var viewModel = WaveMakerViewModel()
    @State var bag = Set<AnyCancellable>()
    var body: some View {
        VStack {
            HStack {
                WaveController(wav: $viewModel.wav1)
                WaveController(wav: $viewModel.wav2, isOn: false)
            }
            HStack {
                WaveController(wav: $viewModel.wav3, isOn: false)
                WaveController(wav: $viewModel.wav4, isOn: false)
            }
        }.onAppear {
            viewModel.$wav1.eraseToAnyPublisher().merge(with: viewModel.$wav2, viewModel.$wav3, viewModel.$wav4).sink { _ in
                self.setWav()
            }.store(in: &bag)
            setWav()
        }
    }
    
    func setWav() {
        wav = {(input: Double) -> Double in
            viewModel.wav1(input)  + viewModel.wav2(input) + viewModel.wav3(input) + viewModel.wav4(input)
        }
    }
}
