import RootFeature
import SwiftUI
import TCACoordinators

@main
struct ZentryApp: App {
    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(
                store: .init(
                    initialState: AppCoordinator.State(),
                    reducer: {
                        AppCoordinator()
                    }
                )
            )
        }
    }
}
