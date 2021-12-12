import SwiftUI

struct ColorOutput {
    let color: Color
    let red: Double
    let green: Double
    let blue: Double
}

struct ColorPicker: View {
    @State var red = 0.5
    @State var blue = 0.5
    @State var green = 0.5
    
    @Binding var outputColor: ColorOutput
    
    var body: some View {
        VStack {
            Rectangle().fill(outputColor.color).frame(width: 40, height: 40, alignment: .center).cornerRadius(20.0).shadow(radius: 2.0)
            Slider(value: $red, in: 0...1) { _ in
                updateOutput()
            }
            Slider(value: $green, in: 0...1) { _ in
                updateOutput()
            }
            Slider(value: $blue, in: 0...1) { _ in
                updateOutput()
            }
        }
    }
    
    func updateOutput() {
        let color = Color(red: red, green: green, blue: blue, opacity: 1.0)
        outputColor = ColorOutput(color: color, red: red, green: green, blue: blue)
    }
}
