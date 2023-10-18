import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.LivingFeature.rawValue,
    targets: [
        .implements(
            module: .feature(.LivingFeature),
            dependencies: [
                .feature(target: .BaseFeature)
            ]
        ),
        .tests(
            module: .feature(.LivingFeature),
            dependencies: [
                .feature(target: .LivingFeature)
            ]
        ),
        .demo(
            module: .feature(.LivingFeature),
            dependencies: [
                .feature(target: .LivingFeature)
            ]
        )
    ]
)
