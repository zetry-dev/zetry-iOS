import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.MainTabFeature.rawValue,
    targets: [
        .implements(module: .feature(.MainTabFeature), dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .HomeFeature),
            .feature(target: .CategoryFeature),
            .feature(target: .LivingFeature)
        ]),
        .tests(module: .feature(.MainTabFeature), dependencies: [
            .feature(target: .MainTabFeature),
            .feature(target: .HomeFeature),
            .feature(target: .CategoryFeature),
            .feature(target: .LivingFeature)
        ]),
        .demo(module: .feature(.MainTabFeature), dependencies: [
            .feature(target: .MainTabFeature),
            .feature(target: .HomeFeature),
            .feature(target: .CategoryFeature),
            .feature(target: .LivingFeature)
        ])
    ]
)
