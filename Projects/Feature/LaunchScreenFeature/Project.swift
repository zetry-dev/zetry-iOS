import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.LaunchScreenFeature.rawValue,
    targets: [
        .implements(module: .feature(.LaunchScreenFeature), dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .MainTabFeature)
        ]),
        .tests(module: .feature(.LaunchScreenFeature), dependencies: [
            .feature(target: .LaunchScreenFeature)
        ])
    ]
)
