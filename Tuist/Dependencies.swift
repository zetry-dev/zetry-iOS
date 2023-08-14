import ConfigurationPlugin
import ProjectDescription

let dependencies = Dependencies(
    carthage: nil,
    swiftPackageManager: SwiftPackageManagerDependencies(
        [
            .remote(url: "https://github.com/pointfreeco/swift-composable-architecture.git", requirement: .exact("1.0.0")),
        ],
        baseSettings: .settings(
            configurations: [
                .debug(name: .dev),
                .debug(name: .stage),
                .release(name: .prod),
            ]
        )
    ),
    platforms: [.iOS]
)
