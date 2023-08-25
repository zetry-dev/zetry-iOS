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

struct ContentView: View {
    var body: some View {
        HStack {
            Button("네네네네네네네네네네네네") {}
                .buttonStyle(.secondary)

            Button("네네네네네네네네네네네네") {}
                .buttonStyle(.primary)
        }
        .padding(.horizontal, 20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
