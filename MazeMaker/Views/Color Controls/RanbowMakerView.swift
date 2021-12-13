import SwiftUI
import Combine

enum WaveType: String, CaseIterable {
    case SIN
    case TRI
    case SQUARE
    case SAW
    case NOISE
    
    var waveForm: (Double) -> Double {
        switch self {
        case .SIN:
            return sin
        case .TRI:
            return triangleWave
        case .NOISE:
            return noise
        case .SQUARE:
            return squareWave
        case .SAW:
            return sawWave
        }
    }
}

struct WaveController: View {
    @Binding var wav: (Double) -> Double
    @State var frequency = 1.0
    @State var magnitude = 0.5
    @State var phase = 0.0
    @State var waveType = WaveType.SIN
    @State var isOn = true
    @State var lift = 1.0
    var body: some View {
        VStack(spacing: 0.0) {
            Toggle(isOn: $isOn) {
                Text(isOn ? "on" : "off")
            }
            Picker(selection: $waveType, label: Text("")) {
                ForEach(WaveType.allCases, id: \.rawValue){ waveType in
                    Text("\(waveType.rawValue)").tag(waveType)
                }
            }.pickerStyle(SegmentedPickerStyle()).frame(height: 100).padding()
            Group {
                HStack {
                    Text(String(format: "%.02f", frequency))
                    Slider(value: $frequency, in: 0.0...12.0).onChange(of: frequency) { _ in
                        setWave()
                    }
                }
                HStack {
                    Text(String(format: "%.02f", magnitude))
                    Slider(value: $magnitude, in: 0.0...2.0).onChange(of: magnitude) { _ in
                        setWave()
                    }
                }
                
                HStack {
                    Text(String(format: "%.02f", phase))
                    Slider(value: $phase, in: (Double.pi*(-2))...Double.pi*(2)).onChange(of: phase) { _ in
                        setWave()
                    }
                }
                
                HStack {
                    Text(String(format: "%.02f", lift))
                    Slider(value: $lift, in: (-2...3)).onChange(of: lift) { _ in
                        setWave()
                    }
                }
            }.frame(width: 250)
                .disabled(!isOn)
        }.padding([.top, .bottom])
            .border(Color.white, width: 4)
            .onChange(of: waveType) { _ in
                setWave()
            }.onChange(of: isOn) { isOn in
                setWave()
            }
    }
    
    func setWave() {
        wav = isOn ? { waveType.waveForm($0*frequency + phase)*magnitude + lift}: { (_:Double) in 0}
    }
}

struct WaveBowView: View {
    var redWav: (Double) -> Double = sin
    var blueWav: (Double) -> Double = sin
    var greenWav: (Double) -> Double = sin
    var body: some View {
        VStack {
            ColorBandView(redWav: redWav, blueWav: blueWav, greenWav: greenWav)
                .padding()
            
            ZStack {
//                WaveView(frequency: 1.0, wav: {redWav($0) + blueWav($0) + greenWav($0)}, color: .white.opacity(0.5))
                WaveView(frequency: 1.0, wav: redWav, color: .red.opacity(0.5))
                WaveView(frequency: 1.0, wav: blueWav, color: .blue.opacity(0.5))
                WaveView(frequency: 1.0, wav: greenWav, color: .green.opacity(0.5))
            }.frame(width: 600, height: 300)
                .padding()
            
                
            
            //            PolarView(wav: wav)
        }.border(Color.black, width: 4)
    }
}

struct ColorBandView: View  {
    var redWav: (Double) -> Double = sin
    var blueWav: (Double) -> Double = sin
    var greenWav: (Double) -> Double = sin
    var body: some View {
        
        HStack(spacing: 2.0) {
                ForEach(0..<100) { index in
                    let (red, blue, green, color) = calcRGB(index, total: 100, redWav: redWav, blueWav: blueWav, greenWav: greenWav)
                    Rectangle()
                        .fill(color)
                        .frame(width: 4, height: 60)
                }
            }
        
    }
}

struct WaveView: View {
    var title: String = ""
    let frequency: Double
    var wav: (Double) -> Double = sin
    var color: Color
    var body: some View {
        VStack {
            Text(title)
            HStack(spacing: 4) {
                ForEach(0..<100){ index in
                    let wavOutput = (wav(Double(index)/100.0*Double.pi*2*frequency)+1)/2
                    let height = wavOutput*30
                    
                    VStack(spacing: 0.0) {
                        VStack(spacing: 1.0) {
                            Spacer()
                            Rectangle().fill(color).frame(width: 4, height: max(0, height))
                        }
                        VStack {
                            Rectangle().fill(color).frame(width: 4, height: max(0,-height))
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}
