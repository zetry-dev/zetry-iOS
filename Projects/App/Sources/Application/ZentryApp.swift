import RootFeature
import SwiftUI

@main
struct ZentryApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(store: .init(initialState: RootReducer.State(), reducer: {
                RootReducer()
            }))
        }
    }
}
