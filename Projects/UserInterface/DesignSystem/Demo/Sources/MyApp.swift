import DesignSystem
import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct TestSegment: Segments {
    var title: String
}

struct ContentView: View {
    @State private var selection: TestSegment = .init(title: "1번")

    private var segments: [TestSegment] = [
        .init(title: "1번"),
        .init(title: "2번")
    ]

    var body: some View {
        HStack {
            SegmentedPicker($selection, segments: segments)
        }
        .padding(.horizontal, 20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
