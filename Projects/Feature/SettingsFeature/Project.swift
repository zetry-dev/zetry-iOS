import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.SettingsFeature.rawValue,
    targets: [
        .implements(
            module: .feature(.SettingsFeature),
            dependencies: [
                .domain(target: .ProductDomain),
                .feature(target: .BaseFeature)
            ]
        ),
        .tests(
            module: .feature(.SettingsFeature),
            dependencies: [
                .feature(target: .SettingsFeature)
            ]
        ),
        .demo(
            module: .feature(.SettingsFeature),
            dependencies: [
                .feature(target: .SettingsFeature)
            ]
        )
    ]
)
