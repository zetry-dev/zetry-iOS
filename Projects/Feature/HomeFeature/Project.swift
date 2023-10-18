import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.HomeFeature.rawValue,
    targets: [
        .implements(module: .feature(.HomeFeature), dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .SearchFeature),
            .domain(target: .CategoryDomain)
        ]),
        .tests(module: .feature(.HomeFeature), dependencies: [
            .feature(target: .HomeFeature)
        ]),
        .demo(module: .feature(.HomeFeature), dependencies: [
            .feature(target: .HomeFeature)
        ])
    ]
)
