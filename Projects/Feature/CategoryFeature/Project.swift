import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.CategoryFeature.rawValue,
    targets: [
        .implements(module: .feature(.CategoryFeature), dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .SearchFeature),
        ]),
        .tests(module: .feature(.CategoryFeature), dependencies: [
            .feature(target: .CategoryFeature),
        ]),
        .demo(module: .feature(.CategoryFeature), dependencies: [
            .feature(target: .CategoryFeature),
        ]),
    ]
)
