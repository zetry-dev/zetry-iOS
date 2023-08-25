import FirebaseCore
import RootFeature
import SwiftUI
import TCACoordinators

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct ZetryApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

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
