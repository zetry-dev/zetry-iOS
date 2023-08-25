import RootFeature
import SwiftUI
import TCACoordinators

@main
struct ZetryApp: App {
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
            .onAppear {
                UIApplication.shared.addTapGestureRecognizer()
            }
        }
    }
}
