import ConfigurationPlugin
import ProjectDescription

let dependencies = Dependencies(
    carthage: nil,
    swiftPackageManager: SwiftPackageManagerDependencies(
        [
            .remote(url: "https://github.com/firebase/firebase-ios-sdk.git", requirement: .branch("master")),
            .remote(url: "https://github.com/johnpatrickmorgan/TCACoordinators.git", requirement: .exact("0.6.0")),
            .remote(url: "https://github.com/pointfreeco/swift-composable-architecture.git", requirement: .exact("1.1.0")),
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
